module Youroom
  class GetUserList < Request
    attr_reader :billing_id

    def initialize(access_token, billing_id, url=BASE_URL)
      required_structure(billing_id, String, Fixnum)
      @billing_id = billing_id.to_s
      super(access_token, url)
    end

    def path
      File.join(url, 'billings', billing_id, 'billing_users?format=json')
    end
  end
end
