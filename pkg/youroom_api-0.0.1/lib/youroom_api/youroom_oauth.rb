require "rubygems"
require "oauth"

module Youroom

  module Connection
    attr_accessor :oauth
    def get_entries(project, user)
      return nil if !check_user(user) or check_project(project)
      consumer = create_consumer(user)
      # this method set @oauth OAuth::AccessToken Object
      create_access_token(consumer, user)
      throw_oauth_request(project, current_method)
    end

    private
    def throw_oauth_request project, current_method
      method, path = optimize_request(current_method, project.room_id)
      @oauth.instance_eval("#{method}(%q[#{@url+path}])")
    end

    def optimize_request current_method, room_id
      case current_method
        when "get_entries"; ["get", "group/r#{room_id}/entries.json"]
      end
    end

    def create_consumer user
      OAuth::Consumer.new(user.consumer_key, user.consumer_secret, :site=> @url)
    end

    def create_access_token consumer, user
      @oauth ||= OAuth::AccessToken.new(consumer, user.access_token, user.access_token_secret)
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
