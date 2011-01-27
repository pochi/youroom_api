$KCODE= 'u'
require 'rubygems'
begin
  require 'spec'
rescue LoadError
  require 'rspec'
end
require 'ww'
require 'json'


$LOAD_PATH << File.expand_path("../lib", File.dirname(__FILE__))

require "youroom_api.rb"


load File.expand_path("setup_test_model.rb", File.dirname(__FILE__))

Spec::Runner.configure do |config|
  WW_URL = "http://localhost:8083/youroom/"

  # ww config
  WW::Server.handler = :webrick

  WW::Server[:youroom] ||= WW::Server.build_double(8083) do
    # sample spy
    spy.get("/messages/:user.json") do |user|
      content_type "application/json"
      body = [ { :message => "hoge"} ].to_json
    end
  end

  WW::Server.start_once(:youroom)

  def access_token
    @access_token ||= OAuth::AccessToken.new(consumer, "hoge", "hoge")
  end

  def consumer
    @consumer ||= OAuth::Consumer.new("a", "b")
  end

  def create_room
    @create_room ||= mock(Youroom::CreateRoom)
  end

  def create_user
    @create_user ||= mock(Youroom::CreateUser)
  end

  def create_participation
    @create_participation ||= mock(Youroom::CreateParticipation)
  end

  def destroy_participation
    @destroy_participation ||= mock(Youroom::DestroyParticipation)
  end

  def entry
    @entry ||= mock(Youroom::GetEntry)
  end

  def participation
    @participation ||= mock(Youroom::Participation)
  end

  def timeline
    @timeline ||= mock(Youroom::HomeTimeline)
  end

  def unread_timeline
    @timeline ||= mock(Youroom::UnreadTimeline)
  end

  def room_timeline
    @timeline ||= mock(Youroom::RoomTimeline)
  end

  def create_entry_request
    @create_entry_request ||= mock(Youroom::PostEntry)
  end

  def create_my_group_request
    @create_my_group_request ||= mock(Youroom::MyGroup)
  end

  def destroy_entry
    @destroy_entry_request ||= mock(Youroom::DestroyEntry)
  end

  def add_room_request
    @add_room_request ||= mock(Youroom::AddRoom)
  end

  def room_list_request
    @get_room_list ||= mock(Youroom::GetRoomList)
  end

  def add_participation_request
    @add_participation_request ||= mock(Youroom::AddParticipation)
  end

  def destroy_participation_request
    @destroy_participation_request ||= mock(Youroom::DestroyParticipation)
  end

  def add_user_request
    @add_user_request ||= mock(Youroom::AddUser)
  end

  def get_user_list_request
    @get_user_list_request ||= mock(Youroom::GetUserList)
  end

  def user_params
    { :name => 'new user',
      :email => 'pochi.black@gmail.com',
      :password => 'hogehoge',
      :password_confirmation => 'hogehoge' }
  end
end
