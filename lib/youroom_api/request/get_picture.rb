module Youroom
  class Picture < Request
    attr_reader :room_id, :participation_id

    def initialize(access_token, room_id, participation_id=nil,  url=BASE_URL)
      required_structure(room_id, String, Integer)
      @room_id, @participation_id = room_id, participation_id
      super(access_token, url)
    end

    def path
      if participation_id
        File.join(url, "r", room_id, "participations", participation_id, "picture.image")
      else
        File.join(url, "r", room_id, "picture.image")
      end
    end
  end
end
