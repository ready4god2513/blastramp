require './spec/spec_helper'

describe Blastramp::InventoryCountQuery do
  let(:session) { stub_session }
  subject { Blastramp::InventoryCountQuery.new(session) }

  describe "new" do
    it "stores session" do
      subject.session.should === session
    end
  end
  
  describe "inventory_count_proxy" do
    it "uses InventoryCountQuery on API" do
      savon.expects('InventoryCountQuery').with(
        'VendorCode' => 'ABC', 
        'VendorAccessKey' => 'TWX45IX2R9G35394', 
        'Sku' => 'AAA-01-XX').returns(:many)
      subject.find_inventory_counts_for_sku('AAA-01-XX')
    end
  end

end