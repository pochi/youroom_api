class Hash
  # TODO: Refactoring
  def optimize
    Hash.new.tap do |hash|
      self.each do |k,v|
        hash.store(k.to_s,v.to_s) unless v.is_a?(Hash)
        store_k = k.to_s
        while v.is_a?(Hash)
          v.each do |nest_key, nest_val|
            v = nest_val
            store_k += "[" + nest_key.to_s + "]"
            unless v.is_a?(Hash)
              hash.store(store_k,v.to_s)
              store_k = k.to_s
            end
          end
        end
      end
    end
  end
end
