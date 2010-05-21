module Youroom

  class OAuth < Base
    attr_accessor :request

    def initialize(access_token, url=BASE_URL)
      @request = Request.new(access_token, url)
    end

    def entry(room_id, mutter_id=nil)
      request.get_entry(room_id, mutter_id)
    end

    def participation(room_id, participation_id)
      request.get_participation(room_id, participation_id)
    end

    def all_timeline
      request.get_all_timeline
    end

    def unread_timeline
      request.get_unread_timeline
    end
  end
end


