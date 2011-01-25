module Youroom
  class GetEntry < Entry
    attr_reader :room_id, :mutter_id

    def initialize(access_token, room_id, mutter_id=nil, url=BASE_URL)
      required_structure(room_id, String, Symbol, Fixnum)
      required_structure(mutter_id, String, Symbol, Fixnum, NilClass)
      @room_id, @mutter_id = room_id, mutter_id
      super(access_token, url)
    end

    # Refactoring required
    def path
      if !mutter_id.nil?
        File.join(url, 'r', room_id.to_s, 'entries', mutter_id.to_s+'.json')
      else
        File.join(url, 'r', room_id.to_s, 'all?format=json')
      end
    end
  end
end
