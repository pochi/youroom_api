require File.expand_path("../spec_helper", File.dirname(__FILE__))

describe Youroom::Entry do
  def access_token
    @access_token ||= OAuth::AccessToken.new(consumer, "hoge", "hoge")
  end

  def consumer
    @consumer ||= OAuth::Consumer.new("a", "b")
  end

  describe "#initialize" do
    subject { Youroom::Entry.new(access_token, "room_id") }
    it { should be_a(Youroom::Entry) }
    its(:url) { should == Youroom::BASE_URL }
    its(:room_id) { should == "room_id" }
    its(:access_token) { should == access_token }
  end

  describe "#path" do
    before do
      @client = Youroom::Entry.new(access_token, "room_id")
    end

    subject { @client.path }
    it { should == "https://home.youroom.in/group/room_id/entries.json"}
  end
end
