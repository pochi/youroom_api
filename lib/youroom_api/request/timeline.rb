module Youroom
  class HomeTimeline < Request
    # TODO: Request parameter feel bad
    def path
      if url == BASE_URL
        File.join(url, 'all?format=json')
      else
        File.join(url, 'home', 'all?format=json')
      end
    end
  end
end
