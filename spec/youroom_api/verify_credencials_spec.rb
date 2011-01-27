# encoding: utf-8

require File.expand_path("../spec_helper", File.dirname(__FILE__))

describe Youroom::VerifyCredencials do
  describe "#path" do
    context "本家のURLを利用する場合" do
      before do
        @client = Youroom::VerifyCredencials.new(access_token)
      end

      subject { @client.path }

      it "正しいURLが設定されていること" do
        should == File.join(@client.url, 'verify_credencials', '?format=json')
      end
    end

    context "本家を利用しない場合" do
      before do
        @client = Youroom::VerifyCredencials.new(access_token, WW_URL)
      end

      subject { @client.path }
      it "正しいURLが設定されていること" do
        should == File.join(@client.url, 'verify_credencials', '?format=json')
      end
    end
  end
end
