require File.expand_path("../spec_helper", File.dirname(__FILE__))

describe Youroom::MyGroup do
  before do
    @url = "https://home.youroom.in/"
  end

  describe "#path" do
    describe "when url is original" do
      before do
        @client = Youroom::MyGroup.new(access_token)
      end

      subject { @client.path }
      it { should == "https://home.youroom.in/groups/my?format=json"}
    end

    describe "when url is not original" do
      before do
        @client = Youroom::MyGroup.new(access_token, WW_URL)
      end

      subject { @client.path }
      it { should == "http://localhost:8083/youroom/groups/my?format=json"}
    end
  end

  describe "#call" do
    before do
      @client = Youroom::MyGroup.new(access_token, WW_URL)

      # NOTICE: WW not check params
      WW::Server.mock(:youroom, { :format => "json"} ).get("/youroom/groups/my") do
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
