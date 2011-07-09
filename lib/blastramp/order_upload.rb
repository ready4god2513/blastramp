module Blastramp
  class OrderUpload
    # Associations
    attr_reader :session
    attr_reader :order

    def initialize(session, order)
      @session = session
      @order = order
    end
    
    def submit
      # Submit order upload to Blastramp
      endpoint = "http://www.ioperate.net/ws/order/orderws.asmx?wsdl"
      response = session.request endpoint, 'OrderUpload' do
        http.headers["SOAPAction"] = "http://chrome52/webservices/OrderUpload" 
        
        soap.body = {
          'VendorCode' => session.vendor_code,
          'VendorAccessKey' => session.vendor_access_key,
          'Batch' => {:order => order.soap_data}
        }
      end
      response.to_hash[:result]
    end
  end
end
