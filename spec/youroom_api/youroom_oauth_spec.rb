=begin
require File.expand_path("../spec_helper", File.dirname(__FILE__))

describe Youroom::Connection do
  before { @youroom = Youroom::Base.new(Youroom::MUIT_DEV_URL) }

  describe "#oauth_conditions" do
    subject { @youroom.send(:oauth_conditions) }
    it { should be_a(Array) }
  end

  describe "#check_user" do
    describe "when user fill condtion" do
      before do
        @user = OAuthUser.new("hoge", "hoge", "hoge", "hoge")
      end

      subject { @youroom.send(:check_user, @user) }
      it { should be_true }
    end

    describe "when user don't fill condition" do
      describe "case1: column has nil value" do
        before { @user = OAuthUser.new("hoge", "hoge", "hoge", nil) }
        subject { @youroom.send(:check_user, @user) }
        it { should be_false }
      end

      describe "case2: model hasn't required_column" do
        before { @user = User.new("hoge", "hoge", "hoge") }
        subject { @youroom.send(:check_user, @user) }
        it { should be_false }
      end
    end
  end

  describe "#check_project" do
    describe "when project fill condition" do
      before { @project = Project.new(1) }
      subject { @youroom.send(:check_project, @project)}
      it { should be_true }
    end

    describe "when user don't fill condition" do
      describe "case1: column has nil value" do
        before { @project = Project.new }
        subject { @youroom.send(:check_project, @project) }
        it { should be_false }
      end

      describe "case2: model hasn't required_column" do
        before { @user = User.new("hoge", "hoge", "hoge") }
        subject { @youroom.send(:check_project, @user) }
        it { should be_false }
      end
    end
  end

  describe "#create_consumer" do
    before do
      @user = OAuthUser.new("hoge", "hoge", "hoge", "hoge")
    end
    subject { @youroom.send(:create_consumer, @user) }
    it { should be_a(OAuth::Consumer) }
  end

  describe "#create_access_token" do
    before do
      @user = OAuthUser.new("hoge", "hoge", "hoge", "hoge")
      @consumer = @youroom.send(:create_consumer, @user)
      @response = @youroom.send(:create_access_token, @consumer, @user)
    end

    it { @response.should be_a(OAuth::AccessToken) }
    it "@youroom.oauth is existed" do
      @youroom.oauth.should_not be_nil
    end
  end

  describe "#get_entries" do
    before do
      @user = OAuthUser.new(*user_sample)
      # Group_id must 4.(you can config room_id which can access group_id of youroom)
      @project = Project.new(4)
    end

    subject { @youroom.get_entries(@project, @user) }
    it { should be_a(Net::HTTPOK) }
  end

  describe "#throw_oauth_request" do
    before do
      @user = OAuthUser.new(*user_sample)
      # Group_id must 4.(you can config room_id which can access group_id of youroom)
      @project = Project.new(4)
      @consumer = @youroom.send(:create_consumer, @user)
      @youroom.send(:create_access_token, @consumer, @user)
    end

    subject { @youroom.send(:throw_oauth_request, @project, "get_entries") }
    it { should be_a(Net::HTTPOK) }
  end

  describe "#optimize_request" do
    subject { @youroom.send(:optimize_request, "get_entries", "4")}
    it { should be_an(Array)}
    its(:first) { should == "get" }
    its(:last) { should == "group/r4/entries.json" }
  end

  describe "#post_entry" do
    before do
      @user = OAuthUser.new(*user_sample)
      # Group_id must 4.(you can config room_id which can access group_id of youroom)
      @project = Project.new(4)
    end

    subject { @youroom.post_entry(@project, @user, {:entry => {:content=>'test'}}) }
    it { should be_a(Net::HTTPCreated) }
  end

  describe "#post_comment" do
    before do
      @user = OAuthUser.new(*user_sample)
      # Group_id must 4.(you can config room_id which can access group_id of youroom)
      @project = Project.new(4)
      # entry_id 35 is random number in exists entry
      @entry = Entry.new(51)
    end

    subject { @youroom.post_comment(@project, @user, @entry, {:entry => {:content=> "hogehoge"}}) }
    it { should be_a(Net::HTTPCreated) }
  end
end


# this method make can access youroom.
# but this way is not useful. please unplesure this methods test
def user_sample
  %w[lpAxNguShekxmosjlh3i nNsDDRUZbBwTJvKanrlox3KGnLCBhCWIpiDvnkz0 mIlSR3dSHu9CVQaFdfm3 IeEn03M0eumgRmoyzeklhJXIRkcbCdicem4TNKVA]
end
=end
