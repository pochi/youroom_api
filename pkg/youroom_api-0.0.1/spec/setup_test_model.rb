class User
  attr_accessor :name, :mail, :login

  def initialize(name, mail, login)
    @name, @mail, @login = name, mail, login
  end
end

class Project
  attr_accessor :room_id

  def initialize(id)
    @room_id = id
  end
end

class OAuthUser
  attr_accessor :consumer_key, :consumer_secret, :access_token, :access_token_secret

  def initialize(consumer_key, consumer_secret, access_token, access_token_secret)
    @consumer_key = consumer_key
    @consumer_secret = consumer_secret
    @access_token = access_token
    @access_token_secret = access_token_secret
  end
end
