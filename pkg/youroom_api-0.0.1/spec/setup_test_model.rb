class User
  attr_accessor :name, :mail, :login

  def initialize(name, mail, login)
    @name, @mail, @login = name, mail, login
  end
end

class Project
  attr_accessor :room_id

  def initialize(id)
    @room_id = id
  end
end
