# encoding: utf-8

require File.expand_path("../spec_helper", File.dirname(__FILE__))

describe Youroom::ShowAttachment, :current => true do
  describe "#path" do
    context "本家のURLを利用する場合" do
      before do
        @client = Youroom::ShowAttachment.new(access_token, "room_id", "entry_id")
      end

      subject { @client.path }

      it "正しいURLが設定されていること" do
        should == File.join(@client.url, 'r', 'room_id', 'entries', 'entry_id', 'attachment', '?format=json')
      end
    end

    context "本家を利用しない場合" do
      before do
        @client = Youroom::ShowAttachment.new(access_token, "room_id", "entry_id", WW_URL)
      end

      subject { @client.path }
      it "正しいURLが設定されていること" do
        should == File.join(@client.url, 'r', 'room_id', 'entries', 'entry_id', 'attachment', '?format=json')
      end
    end
  end
end
