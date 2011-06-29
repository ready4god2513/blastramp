blastramp
=========

Ruby wrapper for the [blastramp](http://blastramp.com) SOAP API 

Blastramp is a Shipping Services Client Library for polling inventory and submitting shipping orders.

Usage example
-------------

blastramp = Blastramp::Session.new('vendor_code', 'vendor_access_key')
blastramp.connect

# Get inventory count for a product SKU at a specific warehouse:
inventory_count = blastramp.find_inventory_count_for_sku('AAA-01-XX','0001')

If no warehouse parameter is given, will return an array of 
inventory_counts = blastramp.find_inventory_count_for_sku_at_warehouse('AAA-01-XX')

# Create order:
order = Blastramp::OrderUpload.new
order.session = blastramp

order.order_id = '123'
order.order_date = Time.now.strftime("%m/%d/%Y")
order.start_date = Time.now.strftime("%m/%d/%Y")
order.expiry_date = 1.month.from_now.strftime("%m/%d/%Y")
order.num_of_cartons = 1
order.weight = 1
order.ship_method = order.shipping_service
order.warehouse_id = '0001'

ship_address = Blastramp::Address.new
ship_address.name = 'John Smith'
ship_address.line1 = '1222 Oak Street'
ship_address.line2 = 'Apt 205'
ship_address.city = 'Springfield'
ship_address.provstate = 'IL'
ship_address.postalcode = '45678'
ship_address.country = 'USA'
ship_address.phone = '555-555-5555'
order.ship_address = ship_address

order_item = Blastramp::OrderItem.new
order_item.order_id = '123'
order_item.sku = 'AAA-01-XX'
order_item.quantity = 2
order_item.item_value = 12.99
order_item.warehouse_id = '0001'
order.order_items << order_item

order.save
