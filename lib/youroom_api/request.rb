require 'net/http'
require 'uri'

module Youroom
  class Request
    attr_reader :url, :host, :port, :path

    def initialize(url)
      parse(url)
    end

    def request
      Net::HTTP::Post.new(path).tap do |req|
        req.set_form_data(params.optimize)
      end
    end

    def call
      begin
        Net::HTTP.start(host, port) do |http|
          http.request(request)
        end
      rescue => e
        return e
      end
    end

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
