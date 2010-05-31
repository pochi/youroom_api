require File.expand_path("../spec_helper", File.dirname(__FILE__))

describe Youroom::HomeTimeline do
  before do
    @url = "https://home.youroom.in/"
  end

  describe "#path" do
    before do
      @client = Youroom::HomeTimeline.new(access_token, WW_URL)
    end

    subject { @client.path }
    it { should == "http://localhost:8083/youroom/home/all?format=json"}
  end

  describe "#call" do
    before do
      @client = Youroom::HomeTimeline.new(access_token, WW_URL)
      # NOTICE: WW not check params
      WW::Server.mock(:youroom, { :format => "json"} ).get("/youroom/home/all") do
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
