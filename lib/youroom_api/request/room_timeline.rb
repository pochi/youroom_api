module Youroom
  class RoomTimeline < Request
    attr_reader :room_id
    def initialize(access_token, room_id, url=BASE_URL)
      required_structure(room_id, String, Symbol, Fixnum)
      @room_id = room_id
      super(access_token, url)
    end

    def path
      File.join(url, 'r', room_id.to_s, '?format=json')
    end
  end
end
