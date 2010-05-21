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

  describe "#create_room" do
    before do
      @client = Youroom::OAuth.new(access_token, WW_URL)
    end

    it "should receive CreateRoom.new and call" do
      Youroom::CreateRoom.should_receive(:new).and_return(create_room)
      create_room.should_receive(:call)
      @client.create_room("hoge")
    end
  end


  describe "#create_user" do
    before { @client = Youroom::OAuth.new(access_token, WW_URL) }

    it "should receive Createuser.new and call" do
      Youroom::CreateUser.should_receive(:new).and_return(create_user)
      create_user.should_receive(:call)
      @client.create_user("pochi", "test_pochi@gmail.com", "pit01205")
    end
  end

  describe "Participation" do
    before do
      @client = Youroom::OAuth.new(access_token, WW_URL)
    end

    describe "#create_participation" do
      it "should receive CreateParticipation.new and call" do
        Youroom::CreateParticipation.should_receive(:new).and_return(create_participation)
        create_participation.should_receive(:call)
        @client.create_participation("room_id", "test_pochi@gmail.com")
      end
    end

    describe "#destroy_paticipation" do
      it "should receive DestroyParticipation.new and call" do
        Youroom::DestroyParticipation.should_receive(:new).and_return(destroy_participation)
        destroy_participation.should_receive(:call)
        @client.destroy_participation("room_id", "test_pochi@gmail.com")
      end
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
        @client.entry("room_id")
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
end


