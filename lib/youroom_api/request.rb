require 'net/http'
require 'uri'

module Youroom
  class Request < Base
    attr_reader :access_token

    def initialize(access_token, url=BASE_URL)
      required_structure(access_token, ::OAuth::AccessToken)
      @access_token = access_token
      parse(url)
    end

    def get_entry(room_id)
      Entry.new(access_token, room_id, url).call
    end

    def get_participation(room_id, participation_id)
      Participation.new(access_token, room_id, participation_id, url).call
    end

    def call
      access_token.get(path)
    end
  end
end
