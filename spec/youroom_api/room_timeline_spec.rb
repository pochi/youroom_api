require File.expand_path("../spec_helper", File.dirname(__FILE__))

describe Youroom::RoomTimeline do
  describe "#path" do
    describe "when url is original" do
      before do
        @client = Youroom::RoomTimeline.new(access_token, 500)
      end

      subject { @client.path }
      it { should == File.join(@client.url, 'r', '500', '?format=json') }
    end

    describe "when url is not original" do
      before do
        @client = Youroom::RoomTimeline.new(access_token, 500, WW_URL)
      end

      subject { @client.path }
      it { should == File.join(@client.url, 'r', '500', '?format=json')}
    end
  end

  describe "#call" do
    before do
      @client = Youroom::RoomTimeline.new(access_token, 500, WW_URL)
      # dammy ww url
      @client.should_receive(:path).at_least(1).and_return("http://localhost:8083/r/500/?format=json")

      # NOTICE: WW not check params
      WW::Server.mock(:youroom, { :format => "json"} ).get("/r/500/") do
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
