require File.expand_path("../spec_helper", File.dirname(__FILE__))

describe Youroom::Entry do
  describe "#group_host" do
    describe "when url is original" do
      before do
        @client = Youroom::GetEntry.new(access_token, "room_id")
      end

      subject { @client.send(:group_host) }
      it { should == "https://room_id.youroom.in/"}
    end

    describe "when url is not original" do
      before do
        @client = Youroom::GetEntry.new(access_token, "room_id", nil, WW_URL)
      end

      subject { @client.send(:group_host) }
      it { should == WW_URL }
    end
  end
end
