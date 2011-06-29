require './spec/spec_helper'

describe Blastramp::Session do
  subject { Blastramp::Session.new('ABC', 'TWX45IX2R9G35394') }

  describe "new" do
    it "should store authentication details" do
      subject.vendor_code.should == 'ABC'
      subject.vendor_access_key.should == 'TWX45IX2R9G35394'
    end
  end
  
  describe "client" do
    subject { Blastramp::Session.new('ABC', 'TWX45IX2R9G35394') }

    it "returns a Savon::Client" do
      subject.client.should be_instance_of(::Savon::Client)
    end
  end
  
  describe "inventory_counts" do
    it "returns an InventoryCountQuery" do
      subject.inventory_counts.should be_instance_of(Blastramp::InventoryCountQuery)
    end
  
    it "memoizes the proxy" do
      subject.inventory_counts.should === subject.inventory_counts
    end
  end

end
