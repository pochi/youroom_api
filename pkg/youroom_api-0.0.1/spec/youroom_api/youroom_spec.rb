require File.expand_path("../spec_helper", File.dirname(__FILE__))
require "youroom_api/youroom"

describe Youroom::Base do
  describe "#initialize" do
    describe "without url" do
      subject { Youroom::Base.new }

      it { should be_a(Youroom::Base) }
      its(:url) { should == "http://youroom.in/" }
      its(:host) { should == "youroom.in" }
      its(:port) { should == 80 }
      its(:path) { should == "/"}
    end

    describe "with url" do
      subject { Youroom::Base.new("http://sufg1ed2v/youroom/") }

      it { should be_a(Youroom::Base) }
      its(:url) { should == "http://sufg1ed2v/youroom/" }
      its(:host) { should == "sufg1ed2v" }
      its(:port) { should == 80 }
      its(:path) { should == "/youroom/"}
    end
  end

  # this method return Net::HTTP object
  # you can access response follow "res.body"
  describe "#create_room" do
    before { @youroom = Youroom::Base.new(Youroom::MUIT_DEV_URL) }

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

    describe "when can create group" do
      subject { @youroom.create_room("hoge") }
      # Successfull message(Response from youroom)
      its(:msg) { should == "Created" }
    end
  end

  describe "#throw_request" do
    describe "when method is create_room" do
      before do
        @youroom = Youroom::Base.new(Youroom::MUIT_DEV_URL)
      end

      it do
        @youroom.send(:throw_request, "create_room", {:name=>"name"}).should_not be_nil
      end
    end
  end

  describe "#request_path" do
    describe "when method is 'create_room'" do
      before do
        @youroom = Youroom::Base.new(Youroom::MUIT_DEV_URL)
      end

      subject { @youroom.send(:request_path, 'create_room') }
      it { should == "/youroom/redmine/room_create" }
    end

    describe "when method is 'create_user'" do
      before do
        @youroom = Youroom::Base.new(Youroom::MUIT_DEV_URL)
      end

      subject { @youroom.send(:request_path, 'create_user') }
      it { should == "/youroom/redmine/user_create" }
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

    describe "when params is nest" do
      before do
        @youroom = Youroom::Base.new("http://sufg1ed2v/youroom/")
      end

      subject { @youroom.send(:request_params, {:name=> {:first=>"hoge"}}) }
      it { should == "name[first]=hoge"}
    end
  end

  describe "#optimize_params" do
    describe "case1: no nest hash" do
      before do
        @youroom = Youroom::Base.new("http://sufg1ed2v/youroom/")
      end

      subject { @youroom.send(:optimize_params, {:a=> "b" }) }
      it { should == {"a"=>"b"}}
    end

    describe "case2: nested hash" do
      before do
        @youroom = Youroom::Base.new("http://sufg1ed2v/youroom/")
      end

      subject { @youroom.send(:optimize_params, {:a=> "b", :b => {:c=>3} }) }
      it { should == {"a"=>"b", "b[c]"=>"3"}}
    end
  end

  describe "#create_user" do
    before { @youroom = Youroom::Base.new(Youroom::MUIT_DEV_URL) }

    describe "when can create user" do
      # this test is increase youroom user.
      # if you try again, test will fail because email has taken by before test
      before do
        @redmine_user = User.new("pochi", "test_pochi@gmail.com", "pit01205")
      end

      subject { @youroom.create_user(@redmine_user) }
      its(:msg) { should == "Created" }
    end

    describe "when can't call method" do
      it "should be raise_exception" do
        lambda do
          @youroom.create_user({:name=>"pochi",:email=>"hoge@gmail.com",:bpr=>"pit0000001"})
        end.should raise_exception(ArgumentError)
      end
    end
  end


  describe "Participation" do
    # this test is increase youroom participation.
    # if you try again, test will fail because participation has taken by before test
    before do
      @youroom = Youroom::Base.new(Youroom::MUIT_DEV_URL)
      @redmine_project = Project.new(1)
      @redmine_user = User.new("pochi", "test_pochi@gmail.com", "pit01205")
      @user_only_exists_redmine = User.new("alice", "test_alice@gmail.com", "no_exists_user")
    end

    describe "#create_participation" do
      describe "when can crate participation" do
        subject { @youroom.create_participation(@redmine_project, @redmine_user) }
        its(:msg) { should == "Created" }
      end

      describe "when can't create participation" do
        it do
          lambda do
            @youroom.create_participation("hoge", @redmine_user)
          end.should raise_exception(ArgumentError)
        end
      end
    end

    describe "#destroy_paticipation" do
      describe "when can crate participation" do
        subject { @youroom.destroy_participation(@redmine_project, @redmine_user) }
        its(:msg) { should == "OK" }
      end

      describe "when can't create participation" do
        it do
          lambda do
            @youroom.create_participation("hoge", @redmine_user)
          end.should raise_exception(ArgumentError)
        end
      end
    end
  end
end

