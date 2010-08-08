describe Youroom::GetUserList do
  describe "#initialize" do
    describe "when can create instance" do
      subject { Youroom::GetUserList.new(access_token, 3) }
      it { should be_a(Youroom::GetUserList) }
      its(:url) { should == Youroom::BASE_URL }
      its(:billing_id) { should == '3' }
      its(:access_token) { should == access_token }
    end

    describe "when can't create instance" do
      it "should raise ArgumentError" do
        lambda { Youroom::GetUserList.new(access_token, ["hoge"]) }.should raise_exception(ArgumentError)
      end
    end
  end

  describe "#path" do
    describe "when url is default" do
      before do
        @client = Youroom::GetUserList.new(access_token, 3)
      end

      subject { @client.path }
      it { should == File.join(@client.url, 'billings', '3', 'billing_users?format=json') }
    end

    describe "when url is customized" do
      before do
        @client = Youroom::GetUserList.new(access_token, 3, WW_URL)
      end

      subject { @client.path }
      it { should == File.join(@client.url, 'billings', '3', 'billing_users?format=json') }
    end
  end

  describe "#call" do
    before do
      @client = Youroom::GetUserList.new(access_token, 3, WW_URL)
      WW::Server.mock(:youroom).get("/youroom/billings/3/billing_users") do
        { :status => "Created" }.to_json
      end
    end

    after do
      WW::Server.verify(:youroom)
    end

    subject { @client.get }
    it "should call request url" do
      should be_a_instance_of(Net::HTTPOK)
    end
  end
end
