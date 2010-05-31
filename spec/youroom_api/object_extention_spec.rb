require File.expand_path("../spec_helper", File.dirname(__FILE__))

describe Hash do
  describe "#optimize" do
    describe "case1: no nest hash" do
      before { @hash = { :a => "b"} }
      subject { @hash.optimize }
      it { should == {"a"=>"b"}}
    end

    describe "case2: nested hash" do
      before { @hash = {:a=> "b", :b => { :c => 3 } } }
      subject { @hash.optimize }
      it { should == {"a"=>"b", "b[c]"=>"3"}}
    end

    describe "case3: nested hash and has many elements in hash" do
      before { @hash = {:a=> "b", :b => { :c => 3, :d => 4 } } }
      subject { @hash.optimize }
      it { should == {"a"=>"b", "b[c]"=>"3", "b[d]"=>"4"}}
    end
  end
end
