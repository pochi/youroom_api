module Youroom
  class Base
    attr_reader :url, :host, :port, :path

    private
    def required_structure(name, *elements)
      raise ArgumentError unless elements.include?(name.class)
    end

    def parse(url)
      @url = url
      uri = URI.parse(url)
      @host, @port, @path = uri.host, uri.port, uri.path
    end
  end
end
