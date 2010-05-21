module Youroom
  class UnreadTimeline < Request
    # TODO: Request parameter feel bad
    def path
      File.join(url, 'home','unreads?format=json')
    end
  end
end
