module Blastramp
  class OrderItem < Entity
    has_properties :order_id, :sku, :quantity, :item_value, :line_note, :carton, :warehouse_id, :category_id
    
    def initialize_defaults
      self.order_id = 0 #  The orderID. Should equal the orderID in the Order
      self.sku = 0 #  The item sku as in the item list as provided to Blastramp
      self.quantity = 0 # Quantity of this item included in the order
      self.item_value = 0.0 # Monetary value of each item in the order currency.
      self.line_note = '' # Other notes or instructions attached to this order item.
      self.carton = '' # Carton identifier for a cross dock order.
      self.warehouse_id = '0001' #  The iOperate identifier for the DC handling the order (should be the same as in the order). Default is "0001"
      self.category_id = '0001' #  The inventory category id to which this product type belongs. Default is "0001"
    end
    
    # Returns OrderedHash with the properties of CurrentInvoice in the correct order, camelcased and ready
    # to be sent via SOAP
    def soap_data
      data = ActiveSupport::OrderedHash.new
      data['orderid'] = order_id
      data['sku'] = sku
      data['quantity'] = quantity
      data['itemValue'] = item_value
      data['lineNote'] = line_note
      data['carton'] = carton
      data['warehouseid'] = warehouse_id
      data['categoryid'] = category_id

      return data
    end
    
  end
end