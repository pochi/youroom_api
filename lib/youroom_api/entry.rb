module Youroom
  class Entry < Request
    attr_reader :room_id, :mutter_id

    def initialize(access_token, room_id, mutter_id=nil, url=BASE_URL)
      required_structure(room_id, String, Symbol)
      required_structure(mutter_id, String, Symbol, Fixnum, NilClass)
      @room_id, @mutter_id = room_id, mutter_id
      super(access_token, url)
    end

    def path
      if !mutter_id.nil?
        File.join(url, 'group', room_id, 'entries', mutter_id.to_s+'.json')
      else
        File.join(url, 'group', room_id, 'entries.json')
      end
    end
  end
end
