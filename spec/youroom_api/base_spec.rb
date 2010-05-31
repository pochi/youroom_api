require File.expand_path("../spec_helper", File.dirname(__FILE__))

describe Youroom::Base do
  describe "enterprise_host" do
    subject { Youroom::Base.new.send(:enterprise_host) }
    it { should == "https://enterprise.youroom.in/"}
  end
end
