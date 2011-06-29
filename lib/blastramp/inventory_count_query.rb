module Blastramp
  class InventoryCountQuery
    # Associations
    attr_reader :session

    def initialize(session)
      @session = session
    end

    def find_inventory_counts_for_sku(sku)
      # Get a list of InventoryCounts from Blastramp
      response = session.request 'InventoryCountQuery' do
        http.headers["SOAPAction"] = "http://chrome52/webservices/InventoryCountQuery" 
        
        soap.body = {
          'VendorCode' => session.vendor_code,
          'VendorAccessKey' => session.vendor_access_key,
          'Sku' => sku
        }
      end

      # # Make sure we always have an array of handles even if the result only contains one
      # handles = [response[:query_results][:counts][:inventory_count]].flatten.reject(&:blank?)
      # 
      # # Create partial InventoryCount entities
      # handles.collect do |handle|
      #   inventory_count = build
      #   inventory_count.persisted = true
      #   inventory_count.whid = handle[:whid]
      #   inventory_count
      # end

    end

  end
end
