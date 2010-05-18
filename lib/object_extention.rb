class Hash
  def optimize
    Hash.new.tap do |hash|
      self.each do |k,v|
        hash.store(k.to_s,v.to_s) unless v.is_a?(Hash)
        while v.is_a?(Hash)
          v.each do |nest_key, nest_val|
            v = nest_val
            store_k = k.to_s + "[" + nest_key.to_s + "]"
            hash.store(store_k,v.to_s)
          end
        end
      end
    end
  end
end
