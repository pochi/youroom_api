require File.expand_path("../spec_helper", File.dirname(__FILE__))

describe Youroom::PostEntry do
  describe "#initialize" do
    describe "when can create instance" do
      subject { Youroom::PostEntry.new(access_token, "room_id", "hogehoge") }
      it { should be_a(Youroom::PostEntry) }
      its(:url) { should == Youroom::BASE_URL }
      its(:room_id) { should == "room_id" }
      its(:content) { should == "hogehoge" }
      its(:access_token) { should == access_token }
    end

    describe "when can't create instance" do
      describe "case1: room_id is not either String or Symbol" do
        it "should raise ArgumentError" do
          lambda { Youroom::PostEntry.new(access_token, 100) }.should raise_exception(ArgumentError)
        end
      end

      describe "case2: content is not either String" do
        it "should raise ArgumentError" do
          lambda { Youroom::PostEntry.new(access_token, "room_id", 14) }.should raise_exception(ArgumentError)
        end
      end
    end
  end

  describe "#path" do
    describe "when url is original" do
      before do
        @client = Youroom::PostEntry.new(access_token, "room_id", "hogehoge")
      end

      subject { @client.path }
      it { should == "https://room_id.youroom.in/entries?format=json"}
    end

    describe "when url is not original" do
      before do
        @client = Youroom::PostEntry.new(access_token, "room_id", "hogehoge", WW_URL)
      end

      subject { @client.path }
      it { should == "http://localhost:8083/youroom/group/room_id/entries?format=json"}
    end
  end

  describe "#post" do
    before do
      @client = Youroom::PostEntry.new(access_token, "room_id", "hogehoge", WW_URL)
      WW::Server.mock(:youroom).post("/youroom/group/room_id/entries") do
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

  describe "#params" do
    before do
      @client = Youroom::PostEntry.new(access_token, "room_id", "hogehoge", WW_URL)
    end

    subject { @client.params }
    it { should == { 'entry[content]' => 'hogehoge', 'insert_mention' => '' } }
  end

end