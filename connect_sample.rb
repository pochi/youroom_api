require "rubygems"
require "youroom_api"

# settings for oauth
url = "https://www.youroom.in/"
consumer_key = "your-consumer-key"
consumer_token = "your-consumer-token"
mail_address = "your-mail-address"
password = "your-youroom-password"

# settings for demo
demo_new_entry = nil
demo_room_id = 500
demo_open_room_id = 1719
demo_open_entry_id = 231979

consumer = OAuth::Consumer.new(consumer_key,
                               consumer_secret,
                               :site => url)

access_token = consumer.get_access_token(nil, {}, {
                                           :x_auth_mode => "client_auth",
                                           :x_auth_username => mail_address,
                                           :x_auth_password => password,
                                         })

client = Youroom::Request.new(access_token)

only_enterprise_methods = [:get_room_list, :get_user_list, :create_room, :create_room, :create_participation, :create_user, :destroy_participation]

client.public_methods.grep(/^get_|^create_|^destroy_/).each do |m|
  puts "[#{m}] demonstration"
  case m
    when :get_entry; puts client.send(m, demo_open_room_id, demo_open_entry_id) #=> sample data
    when :create_entry
      demo_new_entry = client.send(m, demo_room_id, "demonstration!")
      puts demo_new_entry
    when :destroy_entry
       destroy_entry =  client.send(m, demo_room_id, demo_new_entry["entry"]["id"])
       puts destroy_entry
    when *only_enterprise_methods; puts "[pending]  Only enterprise user"
    else puts client.send(m)
  end
  puts "---"*20
end



