class User
  attr_accessor :name, :mail, :bpr

  def initialize(name, mail, bpr)
    @name, @mail, @bpr = name, mail, bpr
  end
end

class Project
  attr_accessor :room_id

  def initialize(id)
    @room_id = id
  end
end
