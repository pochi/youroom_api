module Youroom
  class RoomTimeline < Request
    attr_reader :room_id, :since, :page, :flat, :search_query, :read_state
    QUERY_KEYS = %w[since page flat search_query read_state]

    def initialize(access_token, room_id, params={}, url=BASE_URL)
      required_structure(room_id, String, Symbol, Fixnum)
      required_structure(params, Hash)
      @room_id = room_id
      params.each { |k,v| self.instance_variable_set("@#{k}", v)}
      super(access_token, url)
    end

    def path
      query_str = "&"
      QUERY_KEYS.each do |query_key|
        val = self.instance_variable_get("@#{query_key}")
        query_str += "#{query_key}=#{val}&" if !val.nil?
      end
      File.join(url, 'r', room_id.to_s, '?format=json'+"#{query_str.chop}")
    end
  end
end
