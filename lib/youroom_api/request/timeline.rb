module Youroom
  class HomeTimeline < Request
    # TODO: Request parameter feel bad
    def path
      File.join(url, 'all?format=json')
    end
  end
end
