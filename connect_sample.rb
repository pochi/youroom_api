require "rubygems"
require "youroom_api"

consumer_key = "up3xopytN53tYzIiy4v7"
consumer_secret = "oii4Nl9qEOhumFji6Uq6In5VU4VbhK697hV078kJ"

consumer = OAuth::Consumer.new(consumer_key,
                               consumer_secret,
                               :site => "https://www.youroom.in/")

access_token = consumer.get_access_token(nil, {}, {
                                           :x_auth_mode => "client_auth",
                                           :x_auth_username => "pochi.black@gmail.com",
                                           :x_auth_password => "eyefunny",
                                         })

client = Youroom::Request.new(access_token)

=begin
#client.public_methods.grep(/^get_|^create_|^destroy_/).each do |m|
client.public_methods.grep(/^get_/).each do |m|
  puts "[#{m}] demonstration"
  case m
    when :get_entry; puts client.send(m, 1719, 231979) #=> sample data
    when :get_room_list, :get_user_list, :create_room; puts "[pending]  Only enterprise user"
    else puts client.send(m)
  end
  puts "---"*20
end
=end

client.public_methods.grep(/^create_/).each do |m|
  puts "[#{m}] demonstration"
  case m
    when :create_room, :create_participation, :create_user;  puts "[pending]  Only enterprise user"
    when :create_entry; puts client.send(m, 500, "demonstration!")
    else puts client.send(m)
  end
  puts "---"*20
end
