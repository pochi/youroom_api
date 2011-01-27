module Youroom
  class DestroyEntry < Entry
    attr_reader :room_id, :mutter_id

    def initialize(access_token, room_id, mutter_id, url=BASE_URL)
      required_structure(room_id, String, Symbol, Fixnum)
      required_structure(mutter_id, String, Fixnum)
      @room_id, @mutter_id = room_id, mutter_id
      super(access_token, url)
    end

    def path
      File.join(url, 'r', room_id.to_s, 'entries', mutter_id.to_s+'?format=json')
    end
  end
end
