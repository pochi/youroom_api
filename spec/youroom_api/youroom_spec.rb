require File.expand_path("../spec_helper", File.dirname(__FILE__))

describe Youroom::OAuth do

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

  describe "#initialize" do
    describe "when can create instance" do
      subject { Youroom::OAuth.new(access_token) }

      it { should be_a(Youroom::OAuth) }
      its(:request) { should be_a(Youroom::Request) }
    end

    describe "when can not create instance" do
      it "should raise ArgumentError" do
        lambda {  Youroom::OAuth.new("hoge") }.should raise_exception(ArgumentError)
      end
    end
  end

  describe "#ww" do
    it "should be server is start" do
      expect {
        TCPSocket.open('localhost', '8083').close
      }.should_not == raise_exception(Errno::ECONNREFUSED)
    end
  end

  describe "#entry" do
    before do
      @client = Youroom::OAuth.new(access_token, WW_URL)
    end

    describe "when args size == 1" do
      it "should receive Entry.get_entry" do
        @client.request.should_receive(:get_entry)
        @client.entry("room_id")
      end
    end

    describe "when args size == 2" do
      it "should receive Entry.get_entry" do
        @client.request.should_receive(:get_entry)
        @client.entry("room_id", "mutter_id")
      end
    end
  end

  describe "#participation" do
    before do
      @client = Youroom::OAuth.new(access_token, WW_URL)
    end

    it "should receive Participation.get_participation" do
      @client.request.should_receive(:get_participation)
      @client.participation("room_id", "participation_id")
    end
  end

  describe "#all_timeline" do
    before do
      @client = Youroom::OAuth.new(access_token, WW_URL)
    end

    it "should receive Participation.get_participation" do
      @client.request.should_receive(:get_all_timeline)
      @client.all_timeline
    end
  end

  describe "#unread_timeline" do
    before do
      @client = Youroom::OAuth.new(access_token, WW_URL)
    end

    it "should receive Participation.get_participation" do
      @client.request.should_receive(:get_unread_timeline)
      @client.unread_timeline
    end
  end

  describe "#update(room_id, mutter_content)" do
    before do
      @client = Youroom::OAuth.new(access_token, WW_URL)
    end

    it "should receive CreateEntry.new" do
      @client.request.should_receive(:post_entry)
      @client.update("room_id", "hogehoge")
    end
  end
end


