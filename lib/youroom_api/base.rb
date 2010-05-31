module Youroom
  class Base
    attr_reader :url, :host, :port

    private
    def required_structure(name, *elements)
      raise ArgumentError unless elements.include?(name.class)
    end

    def parse(url)
      @url = url
      uri = URI.parse(url)
      @host, @port = uri.host, uri.port
    end

    def enterprise_host
      # production url
      #"https://enterprise.youroom.in/"
      # development url
      "https://enterprise.youroom.sg/"
    end
  end
end
