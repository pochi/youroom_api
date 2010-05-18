class Object
  def current_method
    caller.first.scan(/`(.*)'/).to_s
  end
end

class Hash
  def optimize
    return_hash = {}

    self.each do |k,v|
      return_hash.store(k.to_s,v.to_s) unless v.is_a?(Hash)
      while v.is_a?(Hash)
        v.each do |nest_key, nest_val|
          v = nest_val
          store_k = k.to_s + "[" + nest_key.to_s + "]"
          return_hash.store(store_k,v.to_s)
        end
      end
    end

    return_hash
  end
end
