require File.expand_path("../spec_helper", File.dirname(__FILE__))

describe Youroom::Participation do
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
        lambda { Youroom::Participation.new(*@error_data1) }.should raise_exception(ArgumentError)
      end

      it do
        lambda { Youroom::Participation.new(*@error_data2) }.should raise_exception(ArgumentError)
      end

    end

    describe "when can create user instance" do
      subject { Youroom::Participation.new("room_id", "test_pochi@gmail.com") }
      it { should be_a(Youroom::Participation) }
      its(:url) { should == @url }
      its(:room_id) { should == "room_id" }
      its(:email) { should == "test_pochi@gmail.com" }
    end
  end

  describe "#params" do
    before do
      @participation = Youroom::Participation.new("room_id", "test_pochi@gmail.com")
    end
    subject { @participation.params }
    it { should == { :room_id => "room_id", :email => "test_pochi@gmail.com"} }
  end

end
