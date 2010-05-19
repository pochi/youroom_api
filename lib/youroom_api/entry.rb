module Youroom
  class Entry < Request
    attr_reader :room_id, :access_token

    def initialize(access_token, room_id, url=BASE_URL)
      @room_id = room_id
      super(access_token, url)
    end

    def path
      File.join(url, 'group', room_id, 'entries.json')
    end
  end
end
