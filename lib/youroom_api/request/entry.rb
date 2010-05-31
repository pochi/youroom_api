module Youroom
  class Entry < Request
    private
    def group_host
      url == BASE_URL ? "https://#{room_id}.youroom.in/" : url
    end
  end
end
