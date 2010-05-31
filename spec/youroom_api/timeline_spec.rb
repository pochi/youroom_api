require File.expand_path("../spec_helper", File.dirname(__FILE__))

describe Youroom::HomeTimeline do
  before do
    @url = "https://home.youroom.in/"
  end

  describe "#path" do
    describe "when url is original" do
      before do
        @client = Youroom::HomeTimeline.new(access_token)
      end

      subject { @client.path }
      it { should == "https://home.youroom.in/all?format=json"}
    end

    describe "when url is not original" do
      before do
        @client = Youroom::HomeTimeline.new(access_token, WW_URL)
      end

      subject { @client.path }
      it { should == "http://localhost:8083/youroom/home/all?format=json"}
    end
  end

  describe "#call" do
    before do
      @client = Youroom::HomeTimeline.new(access_token, WW_URL)
      # dammy ww url
      @client.should_receive(:path).and_return("http://localhost:8083/all?format=json")

      # NOTICE: WW not check params
      WW::Server.mock(:youroom, { :format => "json"} ).get("/all") do
        { :entry => "hogehoge" }.to_json
      end
    end

    after do
      WW::Server.verify(:youroom)
    end

    subject { @client.call }
    it "should call request url" do
      should be_a_instance_of(Net::HTTPOK)
    end
  end

end
