require 'object_extention'
require 'uri'
require 'net/http'

module Youroom
  BASE_URL = 'https://home.youroom.in/'

  class OAuth
    attr_accessor :url, :host, :port, :path, :header, :request

    def initialize(access_token, url='https://home.youroom.in/')
      @url = url
      parse(@url)
      @header = ""
    end

    def create_room(name)
      @request = CreateRoom.new(name, url)
      request.call
    end

    def create_user(name, email, bpr=nil)
      @request = CreateUser.new(name, email, bpr, url)
      request.call
    end

    def create_participation(room_id, email)
      @request = CreateParticipation.new(room_id, email, url)
      request.call
    end

    def destroy_participation(project, user)
      if required_structure(project, Project) and required_structure(user, User)
        throw_request(current_method, {:room_id => project.room_id.to_s, :bpr => user.login} )
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
        req = Net::HTTP::Post.new(request_path(method))
        req.set_form_data(optimize_params(params))

        Net::HTTP.start(@host, @port) do |http|
          http.request(req)
        end
      rescue => e
        return e
      end
    end

    def request_path(method)
      case method
        when 'create_participation'; File.join(@path, 'redmine', 'participation', 'create')
        when 'destroy_participation'; File.join(@path, 'redmine', 'participation', 'destroy')
      end
    end

    def optimize_params(params)
      return_hash = {}

      params.each do |k,v|
        return_hash.store(k.to_s,v.to_s) unless v.is_a?(Hash)
        while v.is_a?(Hash)
          v.each do |nest_key, nest_val|
            v = nest_val
            store_k = k.to_s + "[" + nest_key.to_s + "]"
            return_hash.store(store_k,v.to_s)
          end
        end
      end

      return_hash
    end
  end

end


