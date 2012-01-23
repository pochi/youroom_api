# coding: utf-8

module Youroom
  class Mark < Request
    attr_reader :ids

    def initialize(access_token, ids, url=BASE_URL)
      required_structure(ids, Array, String, Fixnum)
      @ids = if ids.is_a?(Array)
               ids.map { |id| id.to_s }
             else
               [ids.to_s]
             end
      super(access_token, url)
    end

    def params
      { :ids => ids.join(",") }
    end
  end
end
