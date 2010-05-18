require File.expand_path("../spec_helper", File.dirname(__FILE__))

describe Youroom::Request do
  describe "#initialize" do
    subject { Youroom::Request.new("http://www.yahoo.co.jp") }
    it { should be_a(Youroom::Request) }
  end

  describe "#request" do
    before do
      @room = Youroom::CreateRoom.new("hoge", WW_URL)
    end
    subject { @room.request }
    it { should be_a(Net::HTTP::Post) }
  end
end
