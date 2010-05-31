module Youroom
  class GetEntry < Entry
    attr_reader :room_id, :mutter_id

    def initialize(access_token, room_id, mutter_id=nil, url=BASE_URL)
      required_structure(room_id, String, Symbol)
      required_structure(mutter_id, String, Symbol, Fixnum, NilClass)
      @room_id, @mutter_id = room_id, mutter_id
      super(access_token, url)
    end

    # Refactoring required
    def path
      if url == BASE_URL
        if !mutter_id.nil?
          File.join(group_host, 'entries', mutter_id.to_s+'.json')
        else
          File.join(group_host, 'all?format=json')
        end
      else
        if !mutter_id.nil?
          File.join(group_host, 'group', room_id, 'entries', mutter_id.to_s+'.json')
        else
          File.join(group_host, 'group', room_id, 'entries.json')
        end
      end
    end
  end
end