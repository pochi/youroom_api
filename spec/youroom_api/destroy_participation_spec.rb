require File.expand_path("../spec_helper", File.dirname(__FILE__))

describe Youroom::Participation do
  describe "#initialize" do
    describe "when can create instance" do
      subject { Youroom::DestroyParticipation.new(access_token, 3, 4, "pochi.black@gmail.com") }
      it { should be_a(Youroom::DestroyParticipation) }
      its(:url) { should == Youroom::BASE_URL }
      its(:billing_id) { should == '3' }
      its(:billing_group_id) { should == '4' }
      its(:email) { should == "pochi.black@gmail.com" }
      its(:access_token) { should == access_token }
    end

    describe "when can't create instance" do
      describe "case1: argument size is wrong" do
        it "should raise ArgumentError" do
          lambda { Youroom::AddRoom.new(access_token, 100) }.should raise_exception(ArgumentError)
        end
      end

      describe "case2: billing_id structure is failed" do
        it "should raise ArgumentError" do
          lambda { Youroom::AddRoom.new(access_token, [100], 100, "pochi@gmail.com") }.should raise_exception(ArgumentError)
        end
      end

      describe "case3: billing_group_id structure is failed" do
        it "should raise ArgumentError" do
          lambda { Youroom::AddRoom.new(access_token, 100, [100], "pochi@gmail.com") }.should raise_exception(ArgumentError)
        end
      end

      describe "case4: email structure is failed" do
        it "should raise ArgumentError" do
          lambda { Youroom::AddRoom.new(access_token, 100, 100, 123) }.should raise_exception(ArgumentError)
        end
      end

    end
  end

  describe "#path" do
    describe "when url is default" do
      before do
        @client = Youroom::DestroyParticipation.new(access_token, 3, 4, "pochi@gmail.com")
      end

      subject { @client.path }
      it { should == File.join(::Youroom::ENTERPRISE_HOST, 'billings', '3', 'billing_groups', '4', 'participations', 'remove?format=json') }
    end

    describe "when url is customized" do
      before do
        @client = Youroom::DestroyParticipation.new(access_token, 3, 4, "pochi@gmail.com", WW_URL)
      end

      subject { @client.path }
      it { should == File.join(WW_URL, 'enterprise', 'billings', '3', 'billing_groups', '4', 'participations', 'remove?format=json') }
    end
  end

  describe "#params" do
    before do
      @client = Youroom::DestroyParticipation.new(access_token, 3, 4, "pochi.black@gmail.com")
    end

    subject { @client.params }
    it { should == {'email' => 'pochi.black@gmail.com' } }
  end

  describe "#post" do
    before do
      @client = Youroom::DestroyParticipation.new(access_token, 3, 4, "pochi@gmail.com", WW_URL)
      WW::Server.mock(:youroom).post("/youroom/enterprise/billings/3/billing_groups/4/participations/remove") do
        { :status => "Deleted" }.to_json
      end
    end

    after do
      WW::Server.verify(:youroom)
    end

    subject { @client.post }
    it "should call request url" do
      should be_a_instance_of(Hash)
    end
  end
end
