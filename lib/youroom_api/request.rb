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

    def get_entry(room_id, mutter_id=nil)
      GetEntry.new(access_token, room_id, mutter_id, url).call
    end

    def get_participation(room_id, participation_id)
      Participation.new(access_token, room_id, participation_id, url).call
    end

    def get_all_timeline
      HomeTimeline.new(access_token, url).call
    end

    def get_unread_timeline
      UnreadTimeline.new(access_token, url).call
    end

    def post_entry(room_id, content)
      PostEntry.new(access_token, room_id, content, url).post
    end

    def get_my_group
      MyGroup.new(access_token, url).call
    end

    def call
      access_token.get(path)
    end

    def post
      access_token.post(path, params)
    end
  end
end
