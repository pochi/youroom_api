class User
  attr_accessor :name, :mail, :bpr

  def initialize(name, mail, bpr)
    @name, @mail, @bpr = name, mail, bpr
  end
end
