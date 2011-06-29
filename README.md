blastramp
=========

Ruby wrapper for the [blastramp](http://blastramp.com) SOAP API 

Blastramp is a Shipping Services Client Library for polling inventory and submitting shipping orders.

Usage example
-------------

    blastramp = Blastramp::Session.new('vendor_code', 'vendor_access_key')

    # Get array of inventory counts for a product SKU at all warehouses:
    inventory_counts = blastramp.inventory_counts.find('1000-BLK-M')

    # Get a single inventory count for one warehouse id:
    inventory_count = blastramp.inventory_counts.find_by_whid('1000-BLK-M','0001')

    # Get # of available_to_sell units from an inventory_count
    inventory_count.available_to_sell
    inventory_count.backordered
    inventory_count.total_shipped
    
    # Create order:
    order = Blastramp::Order.new

    order.order_id = '123'
    order.order_date = Time.now.strftime("%m/%d/%Y")
    order.start_date = Time.now.strftime("%m/%d/%Y")
    order.expiry_date = 1.month.from_now.strftime("%m/%d/%Y")
    order.ship_method = 'UPS Worldwide Standard'
    order.warehouse_id = '0001'

    ship_address = Blastramp::Address.new
    ship_address.name = 'John Smith'
    ship_address.line1 = '1222 Oak Street'
    ship_address.line2 = 'Apt 205'
    ship_address.city = 'Springfield'
    ship_address.provstate = 'IL'
    ship_address.country = 'USA'
    ship_address.phone = '555-555-5555'
    order.ship_address = ship_address
    order.bill_address = ship_address

    order_item = Blastramp::OrderItem.new
    order_item.order_id = '123'
    order_item.sku = 'AAA-01-XX'
    order_item.quantity = 2
    order_item.item_value = 12.99
    order.order_items << order_item

    order_upload = Blastramp::OrderUpload.new(blastramp, order)
    order_upload.submit

    
Credits
-------

Sponsored by [zkron.com](http://zkron.com)

