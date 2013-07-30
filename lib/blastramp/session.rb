module Blastramp
  class Session
    attr_accessor :vendor_code, :vendor_access_key
    attr_accessor :endpoint
    
    def initialize(vendor_code, vendor_access_key)
      self.vendor_code = vendor_code
      self.vendor_access_key = vendor_access_key
      self.endpoint = nil
    end
    
    # Returns the Savon::Client used to connect to Blastramp
    def client      
      @client ||= Savon.client(wsdl: self.endpoint)
    end
    
    # Provides access to the inventory counts
    def inventory_counts
      @inventory_counts ||= InventoryCountQuery.new(self)
    end
    
    def request(ep, action, &block)
      self.endpoint = ep
      response = client.request :soap, action, &block
      response_hash = response.to_hash
      action = action.snake_case
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
