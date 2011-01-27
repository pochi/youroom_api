module Youroom
  class ShowAttachment < Request
    attr_reader :room_id, :entry_id
    def initialize(access_token, room_id, entry_id, url=BASE_URL)
      [room_id, entry_id].each { |e| required_structure(e, String, Symbol, Fixnum) }
      @room_id = room_id
      @entry_id = entry_id
      super(access_token, url)
    end

    def path
      File.join(url, 'r', room_id.to_s, 'entries', entry_id.to_s, 'attachment', '?format=json')
    end
  end
end
