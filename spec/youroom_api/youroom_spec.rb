require File.expand_path("../spec_helper", File.dirname(__FILE__))

describe Youroom::OAuth do

  def access_token
    @access_token ||= mock(OAuth::AccessToken)
  end

  def create_room
    @create_room ||= mock(Youroom::CreateRoom)
  end

  def create_user
    @create_user ||= mock(Youroom::CreateUser)
  end

  describe "#initialize" do
    describe "without url" do
      subject { Youroom::OAuth.new(access_token) }

      it { should be_a(Youroom::OAuth) }
      its(:url) { should == "https://home.youroom.in/" }
      its(:host) { should == "home.youroom.in" }
      its(:path) { should == "/"}
    end

  end

  describe "#ww" do
    it "should be server is start" do
      expect {
        TCPSocket.open('localhost', '8083').close
      }.should_not == raise_exception(Errno::ECONNREFUSED)
    end
  end

  describe "#create_room" do
    before do
      @client = Youroom::OAuth.new(access_token, WW_URL)
    end

    it "should receive CreateRoom.new and call" do
      Youroom::CreateRoom.should_receive(:new).and_return(create_room)
      create_room.should_receive(:call)
      @client.create_room("hoge")
    end
  end

  describe "#request_path" do
    before do
      @client = Youroom::OAuth.new(access_token, WW_URL)
    end

    describe "when method is 'create_participation'" do
      subject { @client.send(:request_path, 'create_participation') }
      it { should == "/youroom/redmine/participation/create" }
    end

    describe "when method is 'destroy_participation'" do
      subject { @client.send(:request_path, 'destroy_participation') }
      it { should == "/youroom/redmine/participation/destroy" }
    end

  end

  describe "#optimize_params" do
    before do
      @client = Youroom::OAuth.new(access_token, WW_URL)
    end

    describe "case1: no nest hash" do
      subject { @client.send(:optimize_params, {:a=> "b" }) }
      it { should == {"a"=>"b"}}
    end

    describe "case2: nested hash" do
      subject { @client.send(:optimize_params, {:a=> "b", :b => {:c=>3} }) }
      it { should == {"a"=>"b", "b[c]"=>"3"}}
    end

    describe "case3: nested hash and has many elements in hash" do
      subject { @client.send(:optimize_params, {:a=> "b", :b => {:c=>3, :d=>4} }) }
      it { should == {"a"=>"b", "b[c]"=>"3", "b[d]"=>"4"}}
    end
  end

  describe "#create_user" do
    before { @client = Youroom::OAuth.new(access_token, WW_URL) }

    it "should receive Createuser.new and call" do
      Youroom::CreateUser.should_receive(:new).and_return(create_user)
      create_user.should_receive(:call)
      @client.create_user("pochi", "test_pochi@gmail.com", "pit01205")
    end
  end

  describe "Participation" do
    # this test is increase youroom participation.
    # if you try again, test will fail because participation has taken by before test
    before do
      @client = Youroom::OAuth.new(access_token, WW_URL)
      @redmine_project = Project.new(1)
      @redmine_user = User.new("pochi", "test_pochi@gmail.com", "pit01205")
      @user_only_exists_redmine = User.new("alice", "test_alice@gmail.com", "no_exists_user")
    end

    describe "#create_participation" do
      describe "when can crate participation" do
        before do
          WW::Server.mock(:youroom, :room_id => @redmine_project.room_id.to_s, :bpr => @redmine_user.login).
                     post("/youroom/redmine/participation/create") do
            { :status => "Created" }.to_json
          end
        end

        after do
          WW::Server.verify(:youroom)
        end

        subject { @client.create_participation(@redmine_project, @redmine_user) }
        it { should be_a_instance_of(Net::HTTPOK) }
      end

      describe "when can't create participation" do
        it do
          lambda do
            @client.create_participation("hoge", @redmine_user)
          end.should raise_exception(ArgumentError)
        end
      end
    end

    describe "#destroy_paticipation" do
      describe "when can crate participation" do
        before do
          WW::Server.mock(:youroom, :room_id => @redmine_project.room_id.to_s, :bpr => @redmine_user.login).
                     post("/youroom/redmine/participation/destroy") do
            { :status => "Created" }.to_json
          end
        end

        after do
          WW::Server.verify(:youroom)
        end

        subject { @client.destroy_participation(@redmine_project, @redmine_user) }
        it { should be_a_instance_of(Net::HTTPOK) }
      end

      describe "when can't create participation" do
        it do
          lambda do
            @client.create_participation("hoge", @redmine_user)
          end.should raise_exception(ArgumentError)
        end
      end
    end

  end
end


