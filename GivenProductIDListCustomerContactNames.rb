print "Enter Product ID and I will find Customer's who ordered it "
productId = gets.chomp
puts "Product ID:#{productId}"
puts "\r"

countUrl = "http://services.odata.org/Northwind/Northwind.svc/Products(#{productId})/Order_Details/$count"
require 'net/http'
require 'json'
count = Net::HTTP.get_response(URI.parse(countUrl)).body
puts "The number of orders for product ID #{productId} is #{count}"

orderDetailsUrl = "http://services.odata.org/Northwind/Northwind.svc/Products(5)/Order_Details?$format=json"
orderDetail = Net::HTTP.get_response(URI.parse(orderDetailsUrl)).body
orderDetailHash = JSON.parse(orderDetail)

orderDetailHash["value"].each do |orderDetail|
	url = "http://services.odata.org/Northwind/Northwind.svc/Orders(#{orderDetail["OrderID"]})/Customer?$format=json"
	customer = Net::HTTP.get_response(URI.parse(url)).body
	customerHash = JSON.parse(customer)
	puts customerHash["ContactName"]
end
