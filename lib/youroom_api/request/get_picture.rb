module Youroom
  class Picture < Request
    attr_reader :room_id, :participation_id

    def initialize(access_token, room_id, participation_id,  url=BASE_URL)
      [room_id, participation_id].each {|arg| required_structure(arg, String, Integer) }
      @room_id, @participation_id = room_id, participation_id
      super(access_token, url)
    end

    def path
      File.join(url, "r", room_id, "participations", participation_id, "picture.image")
    end
  end
end
