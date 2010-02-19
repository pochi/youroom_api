class Object
  def current_method
    caller.first.scan(/`(.*)'/).to_s
  end
end
