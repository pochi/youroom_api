require 'object_extention'
require 'uri'
require 'net/http'

module Youroom
  # you need override here
  BASE_URL = "http://172.31.235.77:8081/youroom/"

  class Base
    attr_accessor :host, :port, :path, :header

    def initialize(url="http://youroom.in/")
      parse(url)
      @header = ""
    end

    def create_room(name)
      if required_structure(name, String, Symbol)
        throw_request(current_method, {:name => name.to_s} )
      else
        raise ArgumentError
      end
    end

    private
    def parse(url)
      uri = URI.parse(url)
      @host, @port, @path = uri.host, uri.port, uri.path
    end

    def required_structure(name, *elements)
      elements.include?(name.class)
    end

    def throw_request(method, params)
      begin
        return Net::HTTP.start(@host, @port) do |http|
                 http.post(request_path(method), request_params(params), @header)
               end
      rescue => e
        return e
      end
    end

    def request_path(method)
      case method
        when 'create_room'; File.join(@path, 'redmine', 'room_create')
      end
    end

    def request_params(params)
      params.inject("") {|res, ary| res += ary.first.to_s + "=" + ary.last + "&" }.chop
    end
  end
end


