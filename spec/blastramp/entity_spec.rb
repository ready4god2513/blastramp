require './spec/spec_helper'

class SpecEntity < Blastramp::Entity
  has_properties :foo, :baz

  def existing_method; end
end

describe Blastramp::Entity do
  let(:session) { stub_session }

  describe "class methods" do
    subject { SpecEntity }

    describe "new" do
      subject { Blastramp::Entity.new }

      it "creates a new instance" do
        subject.should be_instance_of(Blastramp::Entity)
      end

      it "initializes the entity with values from the given hash" do
        entity = SpecEntity.new(:foo => 'bar', :baz => 'qux')
        entity.foo.should == 'bar'
        entity.baz.should == 'qux'
      end
    end

    describe "has_properties" do
      it "creates getter for all properties" do
        subject.expects(:define_method).with('name')
        subject.expects(:define_method).with('age')
        subject.has_properties :name, :age
      end

      it "creates setter for all properties" do
        subject.expects(:attr_writer).with(:name)
        subject.expects(:attr_writer).with(:age)
        subject.has_properties :name, :age
      end

      it "does not clobber existing methods" do
        subject.expects(:define_method).with('existing_method').never
        subject.has_properties :existing_method
      end

    end
  end
end
