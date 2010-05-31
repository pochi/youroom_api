module Youroom
  class GetRoomList < Request
    attr_reader :billing_id

    def initialize(access_token, billing_id, url=BASE_URL)
      required_structure(billing_id, String, Fixnum)
      @billing_id = billing_id.to_s
      super(access_token, url)
    end

    def path
      if url == BASE_URL
        File.join(enterprise_host, 'billings', billing_id, 'billing_groups?format=json')
      else
        File.join(url, 'enterprise', 'billings', billing_id, 'billing_groups?format=json')
      end
    end
  end
end
