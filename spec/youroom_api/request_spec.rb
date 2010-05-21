require File.expand_path("../spec_helper", File.dirname(__FILE__))

describe Youroom::Request do
  def access_token
    @access_token ||= OAuth::AccessToken.new(consumer, "hoge", "hoge")
  end

  def consumer
    @consumer ||= OAuth::Consumer.new("a", "b")
  end

  def entry
    @entry ||= mock(Youroom::Entry)
  end

  def participation
    @participation ||= mock(Youroom::Participation)
  end

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

    it "should call Entry.new" do
      Youroom::Entry.stub!(:new).and_return(entry)
      entry.should_receive(:call)
      Youroom::Request.new(access_token).get_entry("room_id")
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
end
