#Prints the label. This does not add a carriage return after the label.
print "Enter Product ID "
#This collects the user input and removes trailing spaces or carriage returns.
productId = gets.chomp
#This prints the collected product ID
puts "Product ID: #{productId}"
#This prints a carriage return
puts "\r"

#This includes the source code to make http requests
require 'net/http'
#This includes the source code to parse JSON responses to ruby objects
require 'json'
#This is the url to get the number of order details of the given product
url = "http://services.odata.org/Northwind/Northwind.svc/Order_Details/$count?$filter=ProductID%20eq%20#{productId}"
#This sends the http get request for the order details
response = Net::HTTP.get_response(URI.parse(url))
#This gets the body of the response received which is the count of orders
noOfOrders = response.body
#This prints the number of orders for the given product id
puts "The number of orders for product ID #{productId} is #{noOfOrders}"

#This is the url to get the order details of the given product id
ordersUrl = "http://services.odata.org/Northwind/Northwind.svc/Products(#{productId})/Order_Details?$format=json"
#This sends the get request to fetch the order details
ordersResponse = Net::HTTP.get_response(URI.parse(ordersUrl))

data = ordersResponse.body
#This parses the response body from json to a ruby object.
ordersHash = JSON.parse(data)

#This prints the label of the table
puts "Order ID's   Total Price after discount"

#This iterates throught he order details and prints the order id and the price after discount
ordersHash["value"].each do |orderDetail|
	print orderDetail["OrderID"]
	print "          "
	factor = 1 - orderDetail["Discount"].to_f
	price = orderDetail["UnitPrice"].to_f * orderDetail["Quantity"].to_f * factor
	puts "$#{price.round(2)}"
end

