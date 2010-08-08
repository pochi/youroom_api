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

    describe "case4: nested level is 2" do
      before { @hash = {:a=> { :b => { :c => 1 } } } }
      subject { @hash.optimize }
      it { should == { 'a[b][c]' => "1" } }
    end

    describe "case5: nested level is 2 and has many elements in hash" do
      before do
        @hash = {:a=> 1,
                 :b=> {:c => 2,
                       :d => {:e => 3,
                              :f => 4,
                              :g => 5 }}}
      end

      subject { @hash.optimize }
      it do
        should == {'a' => '1',
                   'b[c]' => '2',
                   'b[d][e]' => '3',
                   'b[d][f]' => '4',
                   'b[d][g]' => '5' }
      end
    end

    describe "case6: nested level is 2 and has many elements in hash" do
      before do
        @hash = { :billing_user => { :name => "moge",
                                     :user_attributes => { :email => "hoge@gmail.com",
                                                           :password => "hogehoge",
                                                           :password_confirmation => "hogehoge" }}}
      end

      subject { @hash.optimize }
      it do
        should == {'billing_user[name]' => 'moge',
                   'billing_user[user_attributes][email]' => 'hoge@gmail.com',
                   'billing_user[user_attributes][password]' => 'hogehoge',
                   'billing_user[user_attributes][password_confirmation]' => 'hogehoge' }
      end
    end
  end
end
