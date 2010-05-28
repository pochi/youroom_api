module Youroom
  class PostEntry < Request
    attr_reader :room_id, :content

    def initialize(access_token, room_id, content, url=BASE_URL)
      [room_id, content].each { |arg| required_structure(arg, String, Symbol) }
      @room_id, @content = room_id, content
      super(access_token, url)
    end

    def path
      File.join(url, 'group', room_id, 'entries', 'create')
    end

    def params
      { :entry => { :content => content }, :insert_mention => "" }.optimize
    end
  end
end
