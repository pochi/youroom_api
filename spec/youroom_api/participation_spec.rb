require File.expand_path("../spec_helper", File.dirname(__FILE__))

describe Youroom::CreateParticipation do
  before do
    @url = "https://home.youroom.in/"
  end

  describe "#initialize" do
    describe "when can not create instanse" do
      before do
        @error_data1 = ["hoge", nil]
        @error_data2 = [nil, "hoge"]
      end

      it do
        lambda { Youroom::CreateParticipation.new(*@error_data1) }.should raise_exception(ArgumentError)
      end

      it do
        lambda { Youroom::CreateParticipation.new(*@error_data2) }.should raise_exception(ArgumentError)
      end

    end

    describe "when can create user instance" do
      subject { Youroom::CreateParticipation.new("room_id", "test_pochi@gmail.com") }
      it { should be_a(Youroom::CreateParticipation) }
      its(:url) { should == @url }
      its(:room_id) { should == "room_id" }
      its(:email) { should == "test_pochi@gmail.com" }
    end
  end

  describe "#call" do
    before do
      @participation = Youroom::CreateParticipation.new("room_id", "test_pochi@gmail.com", WW_URL)
      WW::Server.mock(:youroom, :room_id => "room_id", :email => "test_pochi@gmail.com").
                 post("/youroom/redmine/participation/create") do
        { :status => "Created" }.to_json
      end
    end

    after do
      WW::Server.verify(:youroom)
    end

    subject { @participation.call }
    it "should call request url" do
      should be_an_instance_of(Net::HTTPOK)
    end
  end

  describe "#path" do
    before do
      @participation = Youroom::CreateParticipation.new("room_id", "test_pochi@gmail.com", WW_URL)
    end
    subject { @participation.path }
    it { should == "/youroom/redmine/participation/create" }
  end

  describe "#params" do
    before do
      @participation = Youroom::CreateParticipation.new("room_id", "test_pochi@gmail.com")
    end
    subject { @participation.params }
    it { should == { :room_id => "room_id", :email => "test_pochi@gmail.com"} }
  end
end
