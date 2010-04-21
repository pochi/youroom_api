$KCODE= 'u'
require 'rubygems'
require 'spec'
require 'ww'

$LOAD_PATH << File.expand_path("..", File.dirname(__FILE__))
$LOAD_PATH << File.expand_path("../lib", File.dirname(__FILE__))

load File.expand_path("setup_test_model.rb", File.dirname(__FILE__))

Spec::Runner.configure do |config|
  # ww config
  WW::Server.handler = :webrick

  WW::Server[:youroom] ||= WW::Server.build_double(8083) do
    spy.get("/messages/:user.json") do |user|
      content_type "application/json"
      body = [ { :message => "hoge"} ].to_json
    end
  end

  WW::Server.start_once(:youroom)
end
