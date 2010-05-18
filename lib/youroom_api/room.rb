module Youroom
  class CreateRoom < Request
    attr_reader :name

    def initialize(name=nil, url="")
      required_structure(name, String, Symbol)
      @name = name
      super(url)
    end

    def request
      Net::HTTP::Post.new(path).tap do |req|
        req.set_form_data(params.optimize)
      end
    end

    def path
      File.join(@path, 'redmine', 'group', 'create')
    end

    def params
      { :name => @name }
    end
  end
end
