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

    def destroy_participation(room_id, email)
      @request = DestroyParticipation.new(room_id, email, url)
      request.call
    end

    private
    def parse(url)
      uri = URI.parse(url)
      @host, @port, @path = uri.host, uri.port, uri.path
    end
  end

end


