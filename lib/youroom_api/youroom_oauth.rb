module Youroom
  module OAuth
    private
    def check_user(user)
      oauth_conditions.each do |key|
        return false if !user.respond_to?(key) or user.instance_eval(key.to_s).nil?
      end
      return true
    end

    def oauth_conditions
      [:consumer_key, :consumer_secret, :access_token, :access_token_secret]
    end

  end
end
