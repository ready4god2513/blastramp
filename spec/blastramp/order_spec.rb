require './spec/spec_helper'

describe Blastramp::Order do
  subject { Blastramp::Order.new }

  it "inherits from Blastramp::Entity" do
    Blastramp::Order.ancestors.should include(Blastramp::Entity)
  end

  describe "new" do
    it "initializes order_items as an empty array" do
      subject.order_items.should == []
    end
  end

end