module Youroom
  class DestroyEntry < Entry
    attr_reader :room_id, :mutter_id

    def initialize(access_token, room_id, mutter_id, url=BASE_URL)
      required_structure(room_id, String, Symbol)
      required_structure(mutter_id, String, Fixnum)
      @room_id, @mutter_id = room_id, mutter_id
      super(access_token, url)
    end

    def path
      if url == BASE_URL
        File.join(group_host, 'entries', mutter_id.to_s+'?format=json')
      else
        File.join(group_host, 'group', room_id, 'entries', mutter_id.to_s+'?format=json')
      end
    end
  end
end
