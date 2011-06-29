require './spec/spec_helper'

describe Blastramp::Address do
  let(:session) { stub_session }
  subject { Blastramp::Address }

  it "inherits from Blastramp::Entity" do
    Blastramp::Address.ancestors.should include(Blastramp::Entity)
  end
end