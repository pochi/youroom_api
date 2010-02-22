require "rubygems"
require "oauth"

module Youroom
  module Connection
    private
    def create_consumer user
      OAuth::Consumer.new(user.consumer_key, user.consumer_secret, :site=> @url)
    end

    def create_access_token consumer, user
      OAuth::AccessToken.new(consumer, user.access_token, user.access_token_secret)
    end

    def check_user(user)
      oauth_conditions.each do |key|
        return false if !user.respond_to?(key) or user.instance_eval(key.to_s).nil?
      end
      return true
    end

    def oauth_conditions
      [:consumer_key, :consumer_secret, :access_token, :access_token_secret]
    end

    def check_project(project)
      # First condition: arg has room_id method
      # Second condition: value which return project.room_id is not nil
      !(!project.respond_to?("room_id") or project.instance_eval("room_id").nil?)
    end
  end
end
