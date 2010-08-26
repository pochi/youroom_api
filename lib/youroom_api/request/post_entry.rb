module Youroom
  class PostEntry < Entry
    attr_reader :room_id, :content, :parent_id

    def initialize(access_token, room_id, content, parent_id, url=BASE_URL)
      [room_id, content].each { |arg| required_structure(arg, String, Symbol) }
      @room_id, @content, @parent_id = room_id, content, parent_id
      super(access_token, url)
    end

    def path
      File.join(url, 'r', room_id, 'entries?format=json')
    end

    def params
      { :entry => { :content => content, :parent_id => parent_id }, :insert_mention => "" }.optimize
    end
  end
end
