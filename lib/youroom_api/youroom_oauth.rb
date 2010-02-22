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

    # TODO: instance_eval is strange
    def check_project(project)
      # First condition: arg has room_id method
      # Second condition: value which return project.room_id is not nil
      !(!project.respond_to?("room_id") or project.instance_eval("room_id").nil?)
    end
  end
end
