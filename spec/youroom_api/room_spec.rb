require File.expand_path("../spec_helper", File.dirname(__FILE__))

describe Youroom::CreateRoom do
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
        lambda { Youroom::CreateRoom.new(@error_data1, @url) }.should raise_exception(ArgumentError)
      end

      it do
        lambda { Youroom::CreateRoom.new(@error_data2, @url) }.should raise_exception(ArgumentError)
      end
    end

    describe "when normal created" do
      subject { Youroom::CreateRoom.new("hoge", @url) }
      it { should be_a(Youroom::CreateRoom) }
      its(:url) { should == @url }
      its(:name) { should == "hoge" }
    end
  end

  describe "#call" do
    before do
      @room = Youroom::CreateRoom.new("hoge", WW_URL)
      WW::Server.mock(:youroom, :name => "hoge").post("/youroom/redmine/group/create") do
        { :status => "Created" }.to_json
      end
    end

    after do
      WW::Server.verify(:youroom)
    end

    subject { @room.call }
    it "should call request url with {:name=>'hoge'}" do
      should be_an_instance_of(Net::HTTPOK)
    end
  end


  describe "#params" do
    before do
      @room = Youroom::CreateRoom.new("hoge", WW_URL)
    end
    subject { @room.params }
    it { should == { :name => "hoge" }}
  end

  describe "#path" do
    before do
      @room = Youroom::CreateRoom.new("hoge", WW_URL)
    end
    subject { @room.path }
    it { should == "/youroom/redmine/group/create"}
  end
end
