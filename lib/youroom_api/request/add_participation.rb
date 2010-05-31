module Youroom
  class AddParticipation < Request
    attr_reader :billing_id, :billing_group_id, :email

    def initialize(access_token, billing_id, billing_group_id, email, url=BASE_URL)
      [billing_id, billing_group_id].each {|arg| required_structure(arg, String, Symbol, Fixnum)}
      required_structure(email, String)
      @billing_id, @billing_group_id, @email = billing_id.to_s, billing_group_id.to_s, email
      super(access_token, url)
    end

    def path
      if url == BASE_URL
        File.join(enterprise_host, 'billings', billing_id, 'billing_groups', billing_group_id, 'participations', 'add?format=json')
      else
        File.join(url, 'enterprise', 'billings', billing_id, 'billing_groups', billing_group_id, 'participations', 'add?format=json')
      end
    end

    def params
      { :email => email }.optimize
    end
  end
end
