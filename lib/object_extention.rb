class Hash
  # TODO: Refactoring
  def optimize
    routes = []
    singleton_hash = {}
    first_keys = self.keys
    second_keys = []
    third_keys = []

    first_keys.each do |key|
      unless self[key].is_a?(Hash)
        routes << [key]
        next
      end
      second_keys << [key, self[key].keys]
    end

    second_keys.each do |second_key|
      second_key.last.each do |key|
        unless self[second_key.first][key].is_a?(Hash)
          routes << [second_key.first, key]
          next
        end
        third_keys << [second_key.first, key, self[second_key.first][key].keys]
      end
    end

    third_keys.each do |third_key|
      third_key.last.each do |key|
        unless self[third_key.first][third_key[1]][key].is_a?(Hash)
          routes << [third_key.first, third_key[1], key]
          next
        end
        force_keys << [third_key.first, third_key[1], key, self[third_key.first][third_key[1]][key].keys]
      end
    end

    routes.each do |route|
      val = self.dup
      route.each do |key|
        val = val[key]
      end
      base = route.shift.to_s
      key_name = route.inject(base) {|key, map| key.to_s + "[" + map.to_s + "]" }
      singleton_hash.update({key_name=>val.to_s})
    end

    singleton_hash
  end

end
