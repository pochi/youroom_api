module Youroom
  class CreateUser < Request
    attr_reader :name, :email, :bpr

    def initialize(name, email, bpr=nil, url=BASE_URL)
      [name, email].each {|arg| required_structure(arg, String, Symbol)}
      @name, @email, @bpr = name, email, bpr
      super(url)
    end

    def path
      File.join(@path, 'redmine', 'user', 'create')
    end

    def params
      { :name => name, :email => email, :bpr => bpr }
    end
  end
end
