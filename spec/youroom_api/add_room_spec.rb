require File.expand_path("../spec_helper", File.dirname(__FILE__))

describe Youroom::DestroyEntry do
  describe "#initialize" do
    describe "when can create instance" do
      subject { Youroom::AddRoom.new(access_token, 3, "new room") }
      it { should be_a(Youroom::AddRoom) }
      its(:url) { should == Youroom::BASE_URL }
      its(:billing_id) { should == '3' }
      its(:name) { should == "new room" }
      its(:access_token) { should == access_token }
    end

    describe "when can't create instance" do
      it "should raise ArgumentError" do
        lambda { Youroom::AddRoom.new(access_token, 100) }.should raise_exception(ArgumentError)
      end
    end
  end

  describe "#path" do
    describe "when url is default" do
      before do
        @client = Youroom::AddRoom.new(access_token, 3, "newroom")
      end

      subject { @client.path }
      it { should == "https://enterprise.youroom.in/billings/3/billing_groups?format=json"}
    end

    describe "when url is customized" do
      before do
        @client = Youroom::AddRoom.new(access_token, 3, "newroom", WW_URL)
      end

      subject { @client.path }
      it { should == File.join(WW_URL, 'enterprise', 'billings', '3', 'billing_groups?format=json') }
    end
  end

  describe "#params" do
    before do
      @client = Youroom::AddRoom.new(access_token, 3, "newroom")
    end

    subject { @client.params }
    it { should == {'billing_group[group_attributes][name]' => 'newroom' } }
  end

  describe "#post" do
    before do
      @client = Youroom::AddRoom.new(access_token, 3, "hogehoge", WW_URL)
      WW::Server.mock(:youroom).post("/youroom/enterprise/billings/3/billing_groups") do
        { :status => "Created" }.to_json
      end
    end

    after do
      WW::Server.verify(:youroom)
    end

    subject { @client.post }
    it "should call request url" do
      should be_a_instance_of(Net::HTTPOK)
    end
  end
end
