module Blastramp
  class InventoryCountQuery
    # Associations
    attr_reader :session

    def initialize(session)
      @session = session
    end
    
    # Returns a new, unpersisted Blastramp::InventoryCount
    def build(values = {})
      inventory_count = Blastramp::InventoryCount.new(values)
      # inventory_count.session = session
      inventory_count
    end

    def find(sku)
      # Get a list of InventoryCounts from Blastramp
      endpoint = "http://www.ioperate.net/ws/inventory/inventoryws.asmx?wsdl"
      response = session.request endpoint, 'InventoryCountQuery' do
        http.headers["SOAPAction"] = "http://chrome52/webservices/InventoryCountQuery" 
        
        soap.body = {
          'VendorCode' => session.vendor_code,
          'VendorAccessKey' => session.vendor_access_key,
          'Sku' => sku
        }
      end
      
      if (response.to_hash[:result] == 'SUCCESS')      
        # Make sure we always have an array of handles even if the result only contains one
        handles = [response[:query_results][:counts][:inventory_count]].flatten.reject(&:blank?)
      
        # Create partial InventoryCount entities
        handles.collect do |handle|
          inventory_count = build(handle)
          inventory_count
        end
      else
        raise(SKUDoesNotExistError.new)
      end

    end
    
    def find_by_whid(sku, whid)
      counts = self.find(sku)
      counts = counts.select{|i| i.whid == whid}
      count = counts[0]
    end

  end
end
