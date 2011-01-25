require File.expand_path("../spec_helper", File.dirname(__FILE__))

describe Youroom::Request do

  describe "#initialize" do
    subject { Youroom::Request.new(access_token, "http://www.yahoo.co.jp") }
    it { should be_a(Youroom::Request) }
    its(:url) { should == "http://www.yahoo.co.jp"}
    its(:access_token) { should == access_token }
  end

  describe "#get_entry(room_id)" do
    it "should get GetEntry.new" do
      Youroom::GetEntry.should_receive(:new).with(access_token, "room_id", nil, Youroom::BASE_URL).
                                             and_return(entry)
      entry.should_receive(:get)
      Youroom::Request.new(access_token).get_entry("room_id")
    end
  end

  describe "#get_entry(room_id, mutter_id)" do
    it "should get GetEntry.new" do
      Youroom::GetEntry.should_receive(:new).with(access_token, "room_id", "mutter_id", Youroom::BASE_URL).
                                                  and_return(entry)
      entry.should_receive(:get)
      Youroom::Request.new(access_token).get_entry("room_id", "mutter_id")
    end
  end

  describe "#destroy_entry(room_id, mutter_id" do
    it "should get DestroyEntry.new" do
      Youroom::DestroyEntry.should_receive(:new).and_return(destroy_entry)
      destroy_entry.should_receive(:delete)
      Youroom::Request.new(access_token).destroy_entry("room_id", "mutter_id")
    end
  end

  describe "#get_all_timeline" do
    it "should get Youroom:TimeLine.new" do
      Youroom::HomeTimeline.should_receive(:new).and_return(timeline)
      timeline.should_receive(:get)
      Youroom::Request.new(access_token).get_all_timeline
    end
  end

  describe "#get_unread_timeline" do
    it "should get Youroom:TimeLine.new" do
      Youroom::UnreadTimeline.should_receive(:new).and_return(unread_timeline)
      unread_timeline.should_receive(:get)
      Youroom::Request.new(access_token).get_unread_timeline
    end
  end

  describe "#post_entry(room_id, content)" do
    it "should get Youroom:TimeLine.new" do
      Youroom::PostEntry.should_receive(:new).and_return(create_entry_request)
      create_entry_request.should_receive(:post)
      Youroom::Request.new(access_token).post_entry("room_id", "hogehoge")
    end
  end

  describe "#get_my_group" do
    it "should get Youroom:MyGroup.new" do
      Youroom::MyGroup.should_receive(:new).and_return(create_my_group_request)
      create_my_group_request.should_receive(:get)
      Youroom::Request.new(access_token).get_my_group
    end
  end

  describe "#create_room" do
    it "should get Youroom:AddRoom.new" do
      Youroom::AddRoom.should_receive(:new).and_return(add_room_request)
      add_room_request.should_receive(:post)
      Youroom::Request.new(access_token).create_room(3, "new room")
    end
  end

  describe "#get_room_list" do
    it "should get Youroom:GetRoomList.new" do
      Youroom::GetRoomList.should_receive(:new).and_return(room_list_request)
      room_list_request.should_receive(:get)
      Youroom::Request.new(access_token).get_room_list("3")
    end
  end

  describe "#create_participation" do
    it "should get Youroom:AddParticipation.new" do
      Youroom::AddParticipation.should_receive(:new).and_return(add_participation_request)
      add_participation_request.should_receive(:post)
      Youroom::Request.new(access_token).create_participation("3", "4", "pochi.black@gmail.com")
    end
  end

  describe "#destoy_participation" do
    it "should get Youroom:DestroyParticipation.new" do
      Youroom::DestroyParticipation.should_receive(:new).and_return(destroy_participation_request)
      destroy_participation_request.should_receive(:delete)
      Youroom::Request.new(access_token).destroy_participation("3", "4", "pochi.black@gmail.com")
    end
  end

  describe "#create_user" do
    it "should get Youroom::AddUser.new" do
      Youroom::AddUser.should_receive(:new).and_return(add_user_request)
      add_user_request.should_receive(:post)
      Youroom::Request.new(access_token).create_user("3", user_params)
    end
  end

  describe "#get_user_list" do
    it "should get Youroom::GetUserList" do
      Youroom::GetUserList.should_receive(:new).and_return(get_user_list_request)
      get_user_list_request.should_receive(:get)
      Youroom::Request.new(access_token).get_user_list("3")
    end
  end
end

