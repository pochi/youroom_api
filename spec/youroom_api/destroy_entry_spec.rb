require File.expand_path("../spec_helper", File.dirname(__FILE__))

describe Youroom::DestroyEntry do
  describe "#initialize" do
    describe "when can create instance" do
      subject { Youroom::DestroyEntry.new(access_token, "room_id", 1111) }
      it { should be_a(Youroom::DestroyEntry) }
      its(:url) { should == Youroom::BASE_URL }
      its(:room_id) { should == "room_id" }
      its(:mutter_id) { should == 1111 }
      its(:access_token) { should == access_token }
    end

    describe "when can't create instance" do
      describe "case1: room_id is not either String or Symbol" do
        it "should raise ArgumentError" do
          lambda { Youroom::DestroyEntry.new(access_token, 100, 1111) }.should raise_exception(ArgumentError)
        end
      end

      describe "case2: mutter is not either String or Fixnum" do
        it "should raise ArgumentError" do
          lambda { Youroom::PostEntry.new(access_token, "room_id", [1111]) }.should raise_exception(ArgumentError)
        end
      end
    end
  end

  describe "#path" do
    describe "when url is original" do
      before do
        @client = Youroom::DestroyEntry.new(access_token, "room_id", 1111)
      end

      subject { @client.path }
      it { should == File.join(@client.url, 'r', 'room_id', 'entries', '1111?format=json') }
    end

    describe "when url is not original" do
      before do
        @client = Youroom::DestroyEntry.new(access_token, "room_id", 1111, WW_URL)
      end

      subject { @client.path }
      it { should == File.join(@client.url, 'r', 'room_id', 'entries', '1111?format=json') }
    end
  end

  describe "#delete" do
    before do
      @client = Youroom::DestroyEntry.new(access_token, "room_id", 1111, WW_URL)
      WW::Server.mock(:youroom).delete("/youroom/r/room_id/entries/1111") do
        { :status => "Destroy" }.to_json
      end
    end

    after do
      WW::Server.verify(:youroom)
    end

    subject { @client.delete }
    it "should call request url" do
      should be_a_instance_of(Hash)
    end

  end
end
