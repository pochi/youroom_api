# coding: utf-8
require File.expand_path("../spec_helper", File.dirname(__FILE__))

describe Youroom::HomeTimeline do
  describe "#path" do
    describe "when url is original" do
      before do
        @client = Youroom::HomeTimeline.new(access_token)
      end

      subject { @client.path }

      it { should == File.join(@client.url, '?format=json') }
    end

    describe "when url is not original" do
      before do
        @client = Youroom::HomeTimeline.new(access_token, { }, WW_URL)
      end

      subject { @client.path }
      it { should == File.join(@client.url, '?format=json')}
    end

    describe "パラメータを設定する場合" do
      context "sinceを設定する場合" do
        before do
          @client = Youroom::HomeTimeline.new(access_token, { :since => "hogehoge" })
        end

        subject { @client.path }

        it "Queryパラメータにsinceが設定されていること" do
          should == File.join(@client.url, '?format=json&since=hogehoge')
        end
      end

      context "flatを設定する場合" do
        before do
          @client = Youroom::HomeTimeline.new(access_token, { :flat => "true" })
        end

        subject { @client.path }

        it "Queryパラメータにflatが設定されていること" do
          should == File.join(@client.url, '?format=json&flat=true')
        end
      end

      context "pageを設定する場合" do
        before do
          @client = Youroom::HomeTimeline.new(access_token, { :page => 3 })
        end

        subject { @client.path }

        it "Queryパラメータにpageが設定されていること" do
          should == File.join(@client.url, '?format=json&page=3')
        end
      end

      context "read_stateを設定する場合" do
        before do
          @client = Youroom::HomeTimeline.new(access_token, { :read_state => "unread" })
        end

        subject { @client.path }

        it "Queryパラメータにread_stateが設定されていること" do
          should == File.join(@client.url, '?format=json&read_state=unread')
        end
      end

      context "複合オプションを設定した場合" do
        before do
          @client = Youroom::HomeTimeline.new(access_token, { :read_state => "unread", :page => 3, :flat => "true" })
        end

        subject { @client.path }

        it "Queryパラメータに複合パラメータが設定されていること" do
          should == File.join(@client.url, '?format=json&page=3&flat=true&read_state=unread')
        end
      end
    end
  end

  describe "#call" do
    before do
      @client = Youroom::HomeTimeline.new(access_token, { }, WW_URL)
      # dammy ww url
      @client.should_receive(:path).at_least(1).and_return("http://localhost:8083/all?format=json")

      # NOTICE: WW not check params
      WW::Server.mock(:youroom, { :format => "json"} ).get("/all") do
        { :entry => "hogehoge" }.to_json
      end
    end

    after do
      WW::Server.verify(:youroom)
    end

    subject { @client.get }
    it "should call request url" do
      should be_a_instance_of(Hash)
    end
  end

end
