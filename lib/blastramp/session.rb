module Blastramp
  class Session
    attr_accessor :vendor_code, :vendor_access_key
    
    def initialize(vendor_code, vendor_access_key)
      self.vendor_code = vendor_code
      self.vendor_access_key = vendor_access_key
    end
    
    # Returns the Savon::Client used to connect to Blastramp
    def client      
      @client ||= Savon::Client.new do
        wsdl.document = "http://www.ioperate.net/ws/inventory/inventoryws.asmx?wsdl"
        # 
        # wsdl.endpoint = "http://www.ioperate.net/ws/inventory/inventoryws.asmx"
        # wsdl.namespace = "http://chrome52/webservices"
      end
    end
    
    # Provides access to the inventory counts
    def inventory_counts
      @inventory_counts ||= InventoryCountQuery.new(self)
    end
    
    def request(action, &block)
      response = client.request :soap, action, &block
      response_hash = response.to_hash

      response_key = "#{action}_response".intern
      result_key = "#{action}_result".intern
      if response_hash[response_key] && response_hash[response_key][result_key]
        response_hash[response_key][result_key]
      else
        {}
      end
    end

  end
end
