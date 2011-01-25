module Youroom
  class UnreadTimeline < Request
    # TODO: Request parameter feel bad
    def path
      if url == BASE_URL
        File.join(url, '?format=json&read_state=unread')
      else
        File.join(url, 'home', '?format=json&read_state=unread')
      end
    end
  end
end
