require File.expand_path("../spec_helper", File.dirname(__FILE__))

describe Youroom::MyGroup do
  describe "#path" do
    describe "when url is original" do
      before do
        @client = Youroom::MyGroup.new(access_token)
      end

      subject { @client.path }
      it { should == File.join(Youroom::BASE_URL, 'groups', 'my?format=json') }
    end

    describe "when url is not original" do
      before do
        @client = Youroom::MyGroup.new(access_token, WW_URL)
      end

      subject { @client.path }
      it { should == File.join(WW_URL, 'groups', 'my?format=json') }
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

    subject { @client.get }
    it "should call request url" do
      should be_a_instance_of(Hash)
    end
  end

end
