module Youroom
  class MyGroup < Request
    # TODO: Request parameter feel bad
    def path
      File.join(url, 'groups', 'my?format=json')
    end
  end
end
