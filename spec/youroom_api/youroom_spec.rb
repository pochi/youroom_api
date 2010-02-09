require File.expand_path("../spec_helper", File.dirname(__FILE__))
require "youroom_api/youroom"

describe Youroom::Base do
  describe "#initialize" do
    describe "without url" do
      subject { Youroom::Base.new }

      it { should be_a(Youroom::Base) }
      its(:host) { should == "youroom.in" }
      its(:port) { should == 80 }
      its(:path) { should == "/"}
    end

    describe "with url" do
      subject { Youroom::Base.new("http://sufg1ed2v/youroom/") }

      it { should be_a(Youroom::Base) }
      its(:host) { should == "sufg1ed2v" }
      its(:port) { should == 80 }
      its(:path) { should == "/youroom/"}
    end
  end

  describe "#create_room" do
    before { @youroom = Youroom::Base.new }

    describe "when args structure is not 'String' or 'Symbol'" do
      before do
        @ex1 = ["hoge", "moge"]
        @ex2 = {:room_name => "moge"}
      end

      it do
        lambda { @youroom.create_room(@ex1) }.should raise_exception(ArgumentError)
        lambda { @youroom.create_room(@ex2) }.should raise_exception(ArgumentError)
      end
    end
  end

  describe "#throw_request" do
    describe "when method is create_room" do
      before do
        @youroom = Youroom::Base.new(Youroom::BASE_URL)
      end

      it do
        @youroom.create_room("hoge").should_not be_nil
      end
    end
  end

  describe "#request_path" do
    describe "when method is 'create_room'" do
      before do
        @youroom = Youroom::Base.new(Youroom::BASE_URL)
      end

      subject { @youroom.send(:request_path, 'create_room') }
      it { should == "/youroom/redmine/room_create" }
    end
  end

  describe "#request_params" do
    describe "when method is 'create_room'" do
      before do
        @youroom = Youroom::Base.new("http://sufg1ed2v/youroom/")
      end

      subject { @youroom.send(:request_params, {:name=> "hoge" }) }
      it { should == "name=hoge"}
    end
  end
end
