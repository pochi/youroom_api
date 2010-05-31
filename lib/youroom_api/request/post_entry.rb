module Youroom
  class PostEntry < Entry
    attr_reader :room_id, :content

    def initialize(access_token, room_id, content, url=BASE_URL)
      [room_id, content].each { |arg| required_structure(arg, String, Symbol) }
      @room_id, @content = room_id, content
      super(access_token, url)
    end

    def path
      if url == BASE_URL
        File.join(group_host, 'entries?format=json')
      else
        File.join(group_host, 'group', room_id, 'entries?format=json')
      end
    end

    def params
      { :entry => { :content => content }, :insert_mention => "" }.optimize
    end
  end
end
