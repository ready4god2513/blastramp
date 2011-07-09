require './spec/spec_helper'

describe Blastramp::InventoryCountQuery do
  let(:session) { stub_session }
  subject { Blastramp::InventoryCountQuery.new(session) }

  describe "new" do
    it "stores session" do
      subject.session.should === session
    end
  end
  
  describe "inventory_count_query" do
    it "uses InventoryCountQuery on API" do
      savon.expects('InventoryCountQuery').with(
        'VendorCode' => 'ABC', 
        'VendorAccessKey' => 'TWX45IX2R9G35394', 
        'Sku' => 'AAA-01-XX').returns(:many)
      subject.find('AAA-01-XX')
    end
    
    context "when many InventoryCounts exist" do
      before :each do
        savon.stubs('InventoryCountQuery').returns(:many)
      end
    
      let(:results) { subject.find('AAA-01-XX') }
    
      it "returns an InventoryCount object for each result" do
        results.size.should == 2
        results.all? { |result| result.should be_instance_of(Blastramp::InventoryCount) }
      end
    end
    
    context "when one InventoryCount is requested" do
      before :each do
        savon.stubs('InventoryCountQuery').returns(:many)
      end
    
      let(:result) { subject.find_by_whid('AAA-01-XX','0001') }
    
      it "returns a single InventoryCount object" do
        result.should be_instance_of(Blastramp::InventoryCount)
      end
    end

    context "when SKU does not exist" do
      before :each do
        savon.stubs('InventoryCountQuery').returns(:sku_does_not_exist)
      end
    
      it "returns a SKUDoesNotExistError" do
        expect{subject.find('XXXX-99-XX')}.to raise_error(Blastramp::SKUDoesNotExistError)
      end
    end

    context "when one InventoryCount is requested and SKU does not exist" do
      before :each do
        savon.stubs('InventoryCountQuery').returns(:sku_does_not_exist)
      end
    
      it "returns a SKUDoesNotExistError" do
        expect{subject.find_by_whid('AAA-01-XX','0001')}.to raise_error(Blastramp::SKUDoesNotExistError)
      end
    end
   
  end

end