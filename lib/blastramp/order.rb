module Blastramp
  class Order < Entity
    has_properties :order_id, :po, :order_date, :start_date, 
      :expiry_date, :num_of_cartons, :weight, :ship_method, 
      :order_terms, :order_type, :order_currency, :order_tax, 
      :warehouse_currency, :warehouse_id, :note, :season
    
    # Associations
    attr_accessor :order_items, :ship_address, :bill_address

    def initialize
      super
      @order_items = []
      @ship_address = Blastramp::Address.new
      @bill_address = Blastramp::Address.new
    end
    
    def initialize_defaults
      self.order_id = 0 # The order number. If it is to be determined by Blastramp then submit "TBD"
      self.po = 0 #  Customer purchase order number
      self.order_date = Time.now.strftime("%m/%d/%Y") # The order date as dd/mm/yyyy
      self.start_date = Time.now.strftime("%m/%d/%Y") # The orders start date as dd/mm/yyyy. The earliest date the order is expected to be released to the warehouse
      self.expiry_date = (Time.now + 186400).strftime("%m/%d/%Y") #  The orders expiry date as dd/mm/yyyy. The latest date the order would be released to the warehouse
      self.ship_method = nil #  Description of the desired shipping method. More detail is better: if known submit carrier, service description and service code. A list of valid values to be used must be provided to Blastramp
      self.order_terms = "Terms Unknown" #  Description of the order terms. Unknown (and default) "Terms Unknown"
      self.order_type = 'P' # P := Pick and Pack. C := Crossdock.
      self.order_currency = 'USD' #  IATA Currency of the order. Default is "CAD"
      self.order_tax = nil # Tax rate to be applied to the order. Default is the current Canada GST rate.
      self.warehouse_currency = 'USD' # IATA used by the warehouse DC. Default is "CAD"
      self.warehouse_id = '0001'  # The iOperate identifier for the DC handling the order. Default is "0001"
      self.note = nil #  Other notes or instructions to be attached to the order
      self.season = nil # The season code to which the order would apply. All available code must be provided to Chrome52
    end
    
    # Returns OrderedHash with the properties of CurrentInvoice in the correct order, camelcased and ready
    # to be sent via SOAP
    def soap_data
      data = ActiveSupport::OrderedHash.new
      data['orderid'] = order_id
      data['po'] = po
      data['orderDate'] = order_date
      data['startDate'] = start_date
      data['expiryDate'] = expiry_date
      data['numOfCartons'] = num_of_cartons if number_of_cartons.to_i > 0
      data['weight'] = weight if weight.to_f > 0.00
      data['shipMethod'] = ship_method
      data['orderTerms'] = order_terms
      data['orderType'] = order_type
      data['orderCurrency'] = order_currency
      data['orderTax'] = order_tax
      data['warehouseCurrency'] = warehouse_currency
      data['warehouseid'] = warehouse_id
      data['note'] = note
      data['season'] = season
      data['shipAddress'] = ship_address.soap_data
      data['billAddress'] = bill_address.soap_data
      data['orderItems'] = []
      order_items.each do |i|
        data['orderItems'] << {'OrderItem' => i.soap_data}
      end
      
      return data
    end
    
  end
end