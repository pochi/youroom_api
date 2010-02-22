require File.expand_path("../spec_helper", File.dirname(__FILE__))
require "youroom_api/youroom"
require "youroom_api/youroom_oauth"

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
    end
    subject { @youroom.send(:create_access_token, @consumer, @user) }
    it { should be_a(OAuth::AccessToken) }
  end
end
