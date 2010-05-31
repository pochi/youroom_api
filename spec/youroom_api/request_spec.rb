require File.expand_path("../spec_helper", File.dirname(__FILE__))

describe Youroom::Request do

  describe "#initialize" do
    subject { Youroom::Request.new(access_token, "http://www.yahoo.co.jp") }
    it { should be_a(Youroom::Request) }
    its(:url) { should == "http://www.yahoo.co.jp"}
    its(:access_token) { should == access_token }
  end

  describe "#get_entry(room_id)" do
    before do
      request = Youroom::Request.new(access_token)
    end

    it "should call GetEntry.new" do
      Youroom::GetEntry.should_receive(:new).with(access_token, "room_id", nil, Youroom::BASE_URL).
                                             and_return(entry)
      entry.should_receive(:call)
      Youroom::Request.new(access_token).get_entry("room_id")
    end
  end

  describe "#get_entry(room_id, mutter_id)" do
    before do
      request = Youroom::Request.new(access_token)
    end

    it "should call GetEntry.new" do
      Youroom::GetEntry.should_receive(:new).with(access_token, "room_id", "mutter_id", Youroom::BASE_URL).
                                                  and_return(entry)
      entry.should_receive(:call)
      Youroom::Request.new(access_token).get_entry("room_id", "mutter_id")
    end
  end

  describe "#destroy_entry(room_id, mutter_id" do
    before do
      request = Youroom::Request.new(access_token)
    end

    it "should call DestroyEntry.new" do
      Youroom::DestroyEntry.should_receive(:new).and_return(destroy_entry)
      destroy_entry.should_receive(:delete)
      Youroom::Request.new(access_token).destroy_entry("room_id", "mutter_id")
    end
  end

  describe "#get_participation(room_id, participation_id)" do
    before do
      request = Youroom::Request.new(access_token)
    end

    it "should call Participation.new" do
      Youroom::Participation.should_receive(:new).and_return(participation)
      participation.should_receive(:call)
      Youroom::Request.new(access_token).get_participation("room_id", "participation_id")
    end
  end

  describe "#get_all_timeline" do
    before do
      request = Youroom::Request.new(access_token)
    end

    it "should call Youroom:TimeLine.new" do
      Youroom::HomeTimeline.should_receive(:new).and_return(timeline)
      timeline.should_receive(:call)
      Youroom::Request.new(access_token).get_all_timeline
    end
  end

  describe "#get_unread_timeline" do
    before do
      request = Youroom::Request.new(access_token)
    end

    it "should call Youroom:TimeLine.new" do
      Youroom::UnreadTimeline.should_receive(:new).and_return(unread_timeline)
      unread_timeline.should_receive(:call)
      Youroom::Request.new(access_token).get_unread_timeline
    end
  end

  describe "#post_entry(room_id, content)" do
    before do
      request = Youroom::Request.new(access_token)
    end

    it "should call Youroom:TimeLine.new" do
      Youroom::PostEntry.should_receive(:new).and_return(create_entry_request)
      create_entry_request.should_receive(:post)
      Youroom::Request.new(access_token).post_entry("room_id", "hogehoge")
    end
  end

  describe "#get_my_group" do
    before do
      request = Youroom::Request.new(access_token)
    end

    it "should call Youroom:MyGroup.new" do
      Youroom::MyGroup.should_receive(:new).and_return(create_my_group_request)
      create_my_group_request.should_receive(:call)
      Youroom::Request.new(access_token).get_my_group
    end
  end

  describe "#create_room" do
    before do
      request = Youroom::Request.new(access_token)
    end

    it "should call Youroom:AddRoom.new" do
      Youroom::AddRoom.should_receive(:new).and_return(add_room_request)
      add_room_request.should_receive(:post)
      Youroom::Request.new(access_token).create_room(3, "new room")
    end
  end

  describe "#get_room_list" do
    before do
      request = Youroom::Request.new(access_token)
    end

    it "should call Youroom:GetRoomList.new" do
      Youroom::GetRoomList.should_receive(:new).and_return(room_list_request)
      room_list_request.should_receive(:call)
      Youroom::Request.new(access_token).get_room_list("3")
    end
  end
end
