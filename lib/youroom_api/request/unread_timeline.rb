module Youroom
  class UnreadTimeline < Request
    # TODO: Request parameter feel bad
    def path
      if url == BASE_URL
        File.join(url, 'unreads?format=json')
      else
        File.join(url, 'home', 'unreads?format=json')
      end
    end
  end
end
