require File.expand_path("../spec_helper", File.dirname(__FILE__))

describe Youroom::AddUser do
  before do
    @user_params = { :name => 'new user',
                     :email => 'pochi.black@gmail.com',
                     :password => 'hogehoge',
                     :password_confirmation => 'hogehoge' }
  end

  describe "#initialize" do
    describe "when can create instance" do
      subject { Youroom::AddUser.new(access_token, 3, @user_params) }
      it { should be_a(Youroom::AddUser) }
      its(:url) { should == Youroom::BASE_URL }
      its(:name) { should == 'new user' }
      its(:email) { should == 'pochi.black@gmail.com' }
      its(:password) { should == 'hogehoge' }
      its(:password_confirmation) { should == 'hogehoge' }
      its(:billing_id) { should == '3' }
      its(:access_token) { should == access_token }
    end

    describe "when can't create instance" do
      it "should raise ArgumentError" do
        lambda { Youroom::AddUser.new(access_token, 100) }.should raise_exception(ArgumentError)
      end
    end
  end

  describe "#path" do
    describe "when url is default" do
      before do
        @client = Youroom::AddUser.new(access_token, 3, @user_params)
      end

      subject { @client.path }
      it { should == File.join(@client.url, 'billings', '3', 'billing_users?format=json') }
    end

    describe "when url is customized" do
      before do
        @client = Youroom::AddUser.new(access_token, 3, @user_params, WW_URL)
      end

      subject { @client.path }
      it { should == File.join(@client.url, 'billings', '3', 'billing_users?format=json') }
    end
  end

  describe "#params" do
    before do
      @client = Youroom::AddUser.new(access_token, 3, @user_params)
    end

    subject { @client.params }
    it do
      should == { 'billing_user[name]' => 'new user',
                  'billing_user[user_attributes][email]' => 'pochi.black@gmail.com',
                  'billing_user[user_attributes][password]' => 'hogehoge',
                  'billing_user[user_attributes][password_confirmation]' => 'hogehoge' }
    end
  end

  describe "#post" do
    before do
      @client = Youroom::AddUser.new(access_token, 3, @user_params, WW_URL)
      WW::Server.mock(:youroom).post("/youroom/billings/3/billing_users") do
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
