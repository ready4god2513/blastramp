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
        wsdl.endpoint = "http://www.ioperate.net/ws/inventory/inventoryws.asmx"
        wsdl.namespace = "http://chrome52/webservices"
      end
    end
    
    # Authenticates with Blastramp
    def connect
      response = client.request :connect do
        soap.body = {
          'VendorCode' => self.vendor_code,
          'VendorAccessKey' => self.vendor_access_key
        }
      end
    end
    
    # Provides access to the debtors
    def inventory_counts
      @inventory_counts ||= InventoryCountQuery.new(self)
    end

  end
end
