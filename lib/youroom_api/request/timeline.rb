module Youroom
  class HomeTimeline < Request
    attr_reader :room_id, :since, :page, :flat, :read_state
    QUERY_KEYS = %w[since page flat read_state]

    def initialize(access_token, params={}, url=BASE_URL)
      required_structure(params, Hash)
      params.each { |k,v| self.instance_variable_set("@#{k}", v)}
      super(access_token, url)
    end

    def path
      query_str = "&"
      QUERY_KEYS.each do |query_key|
        val = self.instance_variable_get("@#{query_key}")
        query_str += "#{query_key}=#{val}&" if !val.nil?
      end
      File.join(url, '?format=json'+"#{query_str.chop}")
    end
  end
end
