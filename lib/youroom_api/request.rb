require 'net/http'
require 'uri'

module Youroom
  class Request < Base
    attr_reader :access_token

    def initialize(access_token, url=BASE_URL)
      required_structure(access_token, ::OAuth::AccessToken)
      @access_token = access_token
      parse(url)
    end

    def request
      Net::HTTP::Post.new(path).tap do |req|
        req.set_form_data(params.optimize)
      end
    end

    def get_entries(room_id)
      Entry.new(access_token, room_id, url)
    end

    def get_call
      access_token.get(path)
    end

    # deprecated in future
    def call
      begin
        Net::HTTP.start(host, port) do |http|
          http.request(request)
        end
      rescue => e
        return e
      end
    end
  end
end
