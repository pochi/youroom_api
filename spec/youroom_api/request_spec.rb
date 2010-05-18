require File.expand_path("../spec_helper", File.dirname(__FILE__))

describe Youroom::Request do
  describe "#initialize" do
    subject { Youroom::Request.new("http://www.yahoo.co.jp") }
    it { should be_a(Youroom::Request) }
  end
end
