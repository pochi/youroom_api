module Youroom
  class CreateRoom < Request
    attr_reader :name

    def initialize(name=nil, url=Youroom::BASE_URL)
      required_structure(name, String, Symbol)
      @name = name
      super(url)
    end

    def path
      File.join(@path, 'redmine', 'group', 'create')
    end

    def params
      { :name => name }
    end
  end
end
