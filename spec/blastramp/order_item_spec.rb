require './spec/spec_helper'

describe Blastramp::OrderItem do
  let(:session) { stub_session }
  subject { Blastramp::OrderItem }

  it "inherits from Blastramp::Entity" do
    Blastramp::OrderItem.ancestors.should include(Blastramp::Entity)
  end
end