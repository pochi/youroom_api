module Youroom
  class AddRoom < Request
    attr_reader :name, :billing_id

    def initialize(access_token, billing_id, name, url=BASE_URL)
      required_structure(billing_id, String, Fixnum)
      required_structure(name, String, Symbol)
      @billing_id, @name = billing_id.to_s, name.to_s
      super(access_token, url)
    end

    def path
      if url == BASE_URL
        File.join(::Youroom::ENTERPRISE_HOST, 'billings', billing_id, 'billing_groups?format=json')
      else
        File.join(url, 'enterprise', 'billings', billing_id, 'billing_groups?format=json')
      end
    end

    def params
      { :billing_group => { :group_attributes => { :name => name } } }.optimize
    end
  end
end
