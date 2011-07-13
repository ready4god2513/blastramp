module Blastramp
  class OrderUpload
    # Associations
    attr_reader :session
    attr_reader :orders

    def initialize(session, orders)
      @session = session
      @orders = orders
    end
    
    def submit
      # Submit order upload to Blastramp
      endpoint = "http://www.ioperate.net/ws/order/orderws.asmx?wsdl"
      response = session.request endpoint, 'OrderUpload' do
        http.headers["SOAPAction"] = "http://chrome52/webservices/OrderUpload" 
        
        soap.body = {
          'VendorCode' => session.vendor_code,
          'VendorAccessKey' => session.vendor_access_key,
          'Batch' => {'Order' => orders[0].soap_data}
        }
      end
      if (response.to_hash[:result] == 'SUCCESS' && response.to_hash[:orderids])
        response.to_hash[:orderids][:string]
      elsif (response.to_hash[:error] == 'Failed to Authenticate.')
        raise(AuthenticationFailure.new)
      else
        raise "Blastramp: An unknown error occured"
      end
    end    
  end
end
