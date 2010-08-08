require File.expand_path("../spec_helper", File.dirname(__FILE__))

describe Youroom::UnreadTimeline do
  describe "#path" do
    describe "when url is original" do
      before do
        @client = Youroom::UnreadTimeline.new(access_token)
      end

      subject { @client.path }
      it { should == File.join(Youroom::BASE_URL, 'unreads?format=json')}
    end

    describe "when url is not original" do
      before do
        @client = Youroom::UnreadTimeline.new(access_token, WW_URL)
      end

      subject { @client.path }
      it { should == File.join(WW_URL, 'home', 'unreads?format=json') }
    end
  end

  describe "#call" do
    before do
      @client = Youroom::UnreadTimeline.new(access_token, WW_URL)
      WW::Server.mock(:youroom, { :format => "json" }).get("/youroom/home/unreads") do
        { :entry => "hogehoge" }.to_json
      end
    end

    after do
      WW::Server.verify(:youroom)
    end

    subject { @client.get }
    it "should call request url" do
      should be_a_instance_of(Hash)
    end
  end

end
