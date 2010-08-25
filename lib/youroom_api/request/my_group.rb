module Youroom
  class MyGroup < Request
    def path
      File.join(url, 'groups', 'my?format=json')
    end
  end
end
