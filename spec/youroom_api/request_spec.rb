require File.expand_path("../spec_helper", File.dirname(__FILE__))

describe Youroom::Request do
  def access_token
    @access_token ||= OAuth::AccessToken.new(consumer, "hoge", "hoge")
  end

  def consumer
    @consumer ||= OAuth::Consumer.new("a", "b")
  end

  describe "#initialize" do
    subject { Youroom::Request.new(access_token, "http://www.yahoo.co.jp") }
    it { should be_a(Youroom::Request) }
    its(:url) { should == "http://www.yahoo.co.jp"}
    its(:access_token) { should == access_token }
  end

=begin
  describe "#request" do
    before do
      @room = Youroom::Request.new(access_token, WW_URL)
    end
    subject { @room.request }
    it { pending #should be_a(Net::HTTP::Post) }
  end
=end

  describe "#get_entries(room_id)" do
    before do
      request = Youroom::Request.new(access_token)
      @entry = request.get_entries("room_id")
    end

    it { @entry.should be_a(Youroom::Entry) }

    it "should call Entry.new" do
      Youroom::Entry.should_receive(:new)
      Youroom::Request.new(access_token).get_entries("room_id")
    end

  end
end
