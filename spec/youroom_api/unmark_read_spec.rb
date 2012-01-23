require File.expand_path("../spec_helper", File.dirname(__FILE__))

describe Youroom::MarkUnread do
  let :mark_unread do
    Youroom::MarkUnread.new(access_token, [1,2,3])
  end

  describe "#initialize" do
    describe "when can create instance" do
      context "ids are Array class" do
        subject { mark_unread }
        it { should be_a(Youroom::MarkUnread) }
        its(:url) { should == Youroom::BASE_URL }
        its(:ids) { should == ["1","2","3"] }
        its(:access_token) { should == access_token }
      end

      context "ids are String instance" do
        subject { Youroom::MarkUnread.new(access_token, "1") }
        its(:ids) { should == ["1"] }
      end

      context "ids are Integer instance" do
        subject { Youroom::MarkUnread.new(access_token, 1) }
        its(:ids) { should == ["1"] }
      end
    end
  end

  context "#path" do
    subject { mark_unread }
    its(:path) { should == File.join(mark_unread.url, 'mark_unread?format=json') }
  end

  context "#params" do
    subject { mark_unread }
    its(:params) { should == { 'ids[]' => '1,2,3' } }
  end
end
