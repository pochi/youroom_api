require File.expand_path("../spec_helper", File.dirname(__FILE__))

describe Youroom::Picture do
  describe "#initialize" do
    context "when can not create instanse" do
      before do
        @error_data = [nil, "hoge"]
      end

      it do
        lambda { Youroom::Picture.new(*@error_data) }.should raise_exception(ArgumentError)
      end
    end

    context "when can create user instance" do
      subject { Youroom::Picture.new(access_token, "room_id", "participation_id") }
      it { should be_a(Youroom::Picture) }
      its(:url) { should == Youroom::BASE_URL }
      its(:room_id) { should == "room_id" }
      its(:participation_id) { should == "participation_id" }
    end

    context "when participation_id is nil" do
      subject { Youroom::Picture.new(access_token, "room_id") }
      it { should be_a(Youroom::Picture) }
      its(:url) { should == Youroom::BASE_URL }
      its(:room_id) { should == "room_id" }
      its(:participation_id) { should == nil }
    end
  end

  describe "#path" do
    context "when instance has participation_id" do
      before do
        @picture = Youroom::Picture.new(access_token, "room_id", "participation_id", WW_URL)
      end

      subject { @picture.path }
      it { should == File.join(WW_URL, 'r', 'room_id', 'participations', 'participation_id', 'picture.image') }
    end

    context "when instance has not participation_id" do
      before do
        @picture = Youroom::Picture.new(access_token, "room_id", nil, WW_URL)
      end

      subject { @picture.path }
      it { should == File.join(WW_URL, 'r', 'room_id', 'picture.image') }
    end
  end
end
