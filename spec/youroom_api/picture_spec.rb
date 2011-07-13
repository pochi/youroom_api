require File.expand_path("../spec_helper", File.dirname(__FILE__))

describe Youroom::Picture do
  describe "#initialize" do
    context "when can not create instanse" do
      before do
        @error_data1 = ["hoge", nil]
        @error_data2 = [nil, "hoge"]
      end

      it do
        lambda { Youroom::Picture.new(*@error_data1) }.should raise_exception(ArgumentError)
      end

      it do
        lambda { Youroom::Picture.new(*@error_data2) }.should raise_exception(ArgumentError)
      end

    end

    context "when can create user instance" do
      subject { Youroom::Picture.new(access_token, "room_id", "participation_id") }
      it { should be_a(Youroom::Picture) }
      its(:url) { should == Youroom::BASE_URL }
      its(:room_id) { should == "room_id" }
      its(:participation_id) { should == "participation_id" }
    end
  end

  describe "#path" do
    before do
      @picture = Youroom::Picture.new(access_token, "room_id", "participation_id", WW_URL)
    end

    subject { @picture.path }
    it { should == File.join(WW_URL, 'r', 'room_id', 'participations', 'participation_id', 'picture.image') }
  end
end
