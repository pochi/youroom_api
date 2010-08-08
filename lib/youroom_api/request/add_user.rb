module Youroom
  class AddUser < Request
    attr_reader :attributes, :billing_id

    def initialize(access_token, billing_id, attributes, url=BASE_URL)
      required_structure(billing_id, String, Fixnum)
      required_structure(attributes, Hash)
      @billing_id, @attributes = billing_id.to_s, attributes
      super(access_token, url)
    end

    # TODO: refactoring
    def method_missing(name, *args)
      attributes[name.to_sym]
    end

    def path
      File.join(url, 'billings', billing_id, 'billing_users?format=json')
    end

    def params
      { :billing_user => { :name => name,
                           :user_attributes => { :email => email,
                                                 :password => password,
                                                 :password_confirmation => password_confirmation }}}.optimize
    end
  end
end
