require 'uri'
require 'net/http'

host = "172.31.235.77"
port = 8081
path = "/youroom/room_create"
body = "name=hoge"
header = ""

Net::HTTP.start(host, port) do |http|
  http.post(path, body, header)
end
