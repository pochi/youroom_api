require File.expand_path("../spec_helper", File.dirname(__FILE__))

describe Youroom::MarkRead do
  let :mark_read do
    Youroom::MarkRead.new(access_token, [1,2,3])
  end

  describe "#initialize" do
    describe "when can create instance" do
      context "ids are Array class" do
        subject { mark_read }
        it { should be_a(Youroom::MarkRead) }
        its(:url) { should == Youroom::BASE_URL }
        its(:ids) { should == ["1","2","3"] }
        its(:access_token) { should == access_token }
      end

      context "ids are String instance" do
        subject { Youroom::MarkRead.new(access_token, "1") }
        its(:ids) { should == ["1"] }
      end

      context "ids are Integer instance" do
        subject { Youroom::MarkRead.new(access_token, 1) }
        its(:ids) { should == ["1"] }
      end
    end
  end

  context "#path" do
    subject { mark_read }
    its(:path) { should == File.join(mark_read.url, 'mark_read') }
  end

  context "#params" do
    subject { mark_read }
    its(:params) { should == { 'ids[]' => '1,2,3' } }
  end
end
