module Blastramp
  class OrderBatch    
    # Associations
    attr_accessor :orders

    def initialize(orders)
      @orders = orders
    end
    
    # Returns OrderedHash with the properties in the correct order, camelcased and ready
    # to be sent via SOAP
    def soap_data
      data = ActiveSupport::OrderedHash.new
      data[:order] = []
      orders.each do |o|
        data[:order] << o.soap_data
      end
      data
    end
    
  end
end