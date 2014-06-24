print "Enter Product ID "
productId = gets.chomp
puts "Product ID: #{productId}"
puts "\r"

require 'net/http'
require 'json'
url = "http://services.odata.org/Northwind/Northwind.svc/Order_Details/$count?$filter=ProductID%20eq%20#{productId}"
response = Net::HTTP.get_response(URI.parse(url))
noOfOrders = response.body
puts "The number of orders for product ID #{productId} is #{noOfOrders}"

ordersUrl = "http://services.odata.org/Northwind/Northwind.svc/Products(#{productId})/Order_Details?$format=json"
ordersResponse = Net::HTTP.get_response(URI.parse(ordersUrl))

data = ordersResponse.body
ordersHash = JSON.parse(data)

puts "Order ID's   Total Price after discount"
ordersHash["value"].each do |orderDetail|
	print orderDetail["OrderID"]
	print "          "
	factor = 1 - orderDetail["Discount"].to_f
	price = orderDetail["UnitPrice"].to_f * orderDetail["Quantity"].to_f * factor
	puts price
end

