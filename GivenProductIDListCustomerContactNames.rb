#This prints the label asking the user to enter a product ID without a carriage return
print "Enter Product ID and I will find Customer's who ordered it "
#This collects the user input and assigns it to the reference productId
productId = gets.chomp
#This prints the collected product ID
puts "Product ID:#{productId}"
#This prints a carriage return
puts "\r"

#This is the url to fetch the number of order details for the entered product
countUrl = "http://services.odata.org/Northwind/Northwind.svc/Products(#{productId})/Order_Details/$count"
#This includes the source code to make http requests
require 'net/http'
#This includes the source code to parse JSON responses to ruby objects
require 'json'
#This sends the http get request for the order detail count
count = Net::HTTP.get_response(URI.parse(countUrl)).body
#This prints the count received
puts "The number of orders for product ID #{productId} is #{count}"

#This is the url to fetch the order details given the product id
orderDetailsUrl = "http://services.odata.org/Northwind/Northwind.svc/Products(#{productId})/Order_Details?$format=json"
#This sends the http get request for the order details
orderDetail = Net::HTTP.get_response(URI.parse(orderDetailsUrl)).body
#This parses the response into a ruby object
orderDetailHash = JSON.parse(orderDetail)

#This iterates through the order details received and sends a request to fetch the correspoinding customer
#The customer contact name is then printed
orderDetailHash["value"].each do |orderDetail|
	url = "http://services.odata.org/Northwind/Northwind.svc/Orders(#{orderDetail["OrderID"]})/Customer?$format=json"
	customer = Net::HTTP.get_response(URI.parse(url)).body
	customerHash = JSON.parse(customer)
	puts customerHash["ContactName"]
end
