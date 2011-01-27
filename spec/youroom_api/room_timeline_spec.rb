# encoding: utf-8

require File.expand_path("../spec_helper", File.dirname(__FILE__))

describe Youroom::RoomTimeline, :current => true do
  describe "#path" do
    context "本家のURLを利用する場合" do
      before do
        @client = Youroom::RoomTimeline.new(access_token, 500)
      end

      subject { @client.path }

      it "正しいURLが設定されていること" do
        should == File.join(@client.url, 'r', '500', '?format=json')
      end
    end

    context "本家を利用しない場合" do
      before do
        @client = Youroom::RoomTimeline.new(access_token, 500, { }, WW_URL)
      end

      subject { @client.path }
      it "正しいURLが設定されていること" do
        should == File.join(@client.url, 'r', '500', '?format=json')
      end
    end

    describe "パラメータを設定する場合" do
      context "sinceを設定する場合" do
        before do
          @client = Youroom::RoomTimeline.new(access_token, 500, { :since => "hogehoge" })
        end

        subject { @client.path }

        it "Queryパラメータにsinceが設定されていること" do
          should == File.join(@client.url, 'r', '500', '?format=json&since=hogehoge')
        end
      end

      context "serach_queryを設定する場合" do
        before do
          @client = Youroom::RoomTimeline.new(access_token, 500, { :search_query => "hogehoge" })
        end

        subject { @client.path }

        it "Queryパラメータにsearch_queryが設定されていること" do
          should == File.join(@client.url, 'r', '500', '?format=json&search_query=hogehoge')
        end
      end

      context "flatを設定する場合" do
        before do
          @client = Youroom::RoomTimeline.new(access_token, 500, { :flat => "true" })
        end

        subject { @client.path }

        it "Queryパラメータにflatが設定されていること" do
          should == File.join(@client.url, 'r', '500', '?format=json&flat=true')
        end
      end

      context "pageを設定する場合" do
        before do
          @client = Youroom::RoomTimeline.new(access_token, 500, { :page => 3 })
        end

        subject { @client.path }

        it "Queryパラメータにpageが設定されていること" do
          should == File.join(@client.url, 'r', '500', '?format=json&page=3')
        end
      end

      context "read_stateを設定する場合" do
        before do
          @client = Youroom::RoomTimeline.new(access_token, 500, { :read_state => "unread" })
        end

        subject { @client.path }

        it "Queryパラメータにread_stateが設定されていること" do
          should == File.join(@client.url, 'r', '500', '?format=json&read_state=unread')
        end
      end

      context "複合オプションを設定した場合" do
        before do
          @client = Youroom::RoomTimeline.new(access_token, 500, { :read_state => "unread", :page => 3, :flat => "true" })
        end

        subject { @client.path }

        it "Queryパラメータに複合パラメータが設定されていること" do
          should == File.join(@client.url, 'r', '500', '?format=json&page=3&flat=true&read_state=unread')
        end
      end
    end
  end

  describe "#call" do
    before do
      @client = Youroom::RoomTimeline.new(access_token, 500, { }, WW_URL)
      # dammy ww url
      @client.should_receive(:path).at_least(1).and_return("http://localhost:8083/r/500/?format=json")

      # NOTICE: WW not check params
      WW::Server.mock(:youroom, { :format => "json"} ).get("/r/500/") do
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
