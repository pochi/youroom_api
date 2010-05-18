require File.expand_path("../spec_helper", File.dirname(__FILE__))

describe Youroom::CreateUser do
  before do
    @url = "https://home.youroom.in/"
  end

  describe "#initialize" do
    describe "when validation happen" do
      before do
        @error_data1 = ["hoge", "moge"]
        @error_data2 = { :room_name => "moge" }
      end

      it do
        lambda { Youroom::CreateUser.new(@error_data1, nil, nil, @url) }.should raise_exception(ArgumentError)
      end

      it do
        lambda { Youroom::CreateUser.new(nil, @error_data2, nil, @url) }.should raise_exception(ArgumentError)
      end

    end

    describe "when can create user instance" do
      describe "case1: full args" do
        subject { Youroom::CreateUser.new("pochi", "test_pochi@gmail.com", "pit01205", @url) }
        it { should be_a(Youroom::CreateUser) }
        its(:url) { should == @url }
        its(:name) { should == "pochi" }
        its(:email) { should == "test_pochi@gmail.com" }
        its(:bpr) { should == "pit01205" }
      end

      describe "case2: enough args" do
        subject { Youroom::CreateUser.new("pochi", "test_pochi@gmail.com", nil, @url) }
        it { should be_a(Youroom::CreateUser) }
        its(:url) { should == @url }
        its(:name) { should == "pochi" }
        its(:email) { should == "test_pochi@gmail.com" }
        its(:bpr) { should == nil }
      end

    end
  end

  describe "#call" do
    before do
      @user = Youroom::CreateUser.new("pochi", "test_pochi@gmail.com", "pit01205", WW_URL)
      WW::Server.mock(:youroom, :name => "pochi", :email => "test_pochi@gmail.com", :bpr => "pit01205").
                 post("/youroom/redmine/user/create") do
        { :status => "Created" }.to_json
      end
    end

    after do
      WW::Server.verify(:youroom)
    end

    subject { @user.call }
    it "should call request url" do
      should be_an_instance_of(Net::HTTPOK)
    end
  end


  describe "#path" do
    before do
      @user = Youroom::CreateUser.new("pochi", "test_pochi@gmail.com", "pit01205", WW_URL)
    end
    subject { @user.path }
    it { should == "/youroom/redmine/user/create" }
  end

  describe "#params" do
    before do
      @user = Youroom::CreateUser.new("pochi", "test_pochi@gmail.com", "pit01205", WW_URL)
    end
    subject { @user.params }
    it { should == { :name => "pochi", :email => "test_pochi@gmail.com", :bpr => "pit01205"} }
  end
end
