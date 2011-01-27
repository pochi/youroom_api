module Youroom
  class PostEntry < Entry
    attr_reader :room_id, :content, :parent_id

    def initialize(access_token, room_id, content, parent_id=nil, url=BASE_URL)
      [room_id, content].each { |arg| required_structure(arg, String, Symbol, Fixnum) }
      @room_id, @content, @parent_id = room_id, content, parent_id
      super(access_token, url)
    end

    def path
      File.join(url, 'r', room_id.to_s, 'entries?format=json')
    end

    def params
      if parent_id
        { :entry => { :content => content.to_s, :parent_id => parent_id }, :insert_mention => "" }
      else
        { :entry => { :content => content.to_s }, :insert_mention => "" }
      end.optimize
    end
  end
end
