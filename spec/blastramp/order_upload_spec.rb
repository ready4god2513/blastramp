require './spec/spec_helper'

describe Blastramp::OrderUpload do
  let(:session) { stub_session }
  let(:order) { stub_order }
  subject { Blastramp::OrderUpload.new(session, order) }

  describe "new" do
    it "stores session" do
      subject.session.should === session
    end
  end
  
  describe "order_upload" do

    it "uses OrderUpload on API" do
      savon.expects('OrderUpload').with(
        'VendorCode' => 'ABC', 
        'VendorAccessKey' => 'TWX45IX2R9G35394', 
        'Batch' => {:order => order.soap_data}).returns(:success)
      subject.submit
    end    
  end

end