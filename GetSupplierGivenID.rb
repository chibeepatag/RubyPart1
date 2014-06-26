#This prints the label to prompt the user to enter a product id.
print "Enter Product ID "
#This collects the entered product id.
productId = gets.chomp

#This includes the source code to make http requests
require 'net/http'
#This includes the source code to parse JSON responses to ruby objects
require 'json'

#This is the url to fetch the Product given the entered product ID
url = "http://services.odata.org/Northwind/Northwind.svc/Products(#{productId})?$format=json"
#This sends an HTTP get request to fetch the Product
jsonStr = Net::HTTP.get_response(URI.parse(url))

#Assigns the body attribute of jsonStr to the variable data
data = jsonStr.body
#This parses data into a ruby object
jsonHash = JSON.parse(data)

#This prints the product ID
puts "Product ID:#{productId}"
#This prints the product name
puts "Product name: #{jsonHash["ProductName"]}"
#This prints the supplier id
puts "Supplier ID: #{jsonHash["SupplierID"]}"
#This prints the label "Active/Discontinued"
puts "Active/Discontinued"
#This determines if the product is discontinued and prints the label accordingly
if (jsonHash["Discontinued"]) 
      puts jsonHash["ProductName"].to_s + " is a discontinued product"
   else 
      puts jsonHash["ProductName"].to_s + " is an active product"   
end

#This is the url to fetch the supplier given the supplier id
supplierURL = "http://services.odata.org/Northwind/Northwind.svc/Suppliers(#{jsonHash["SupplierID"]})?$format=json"
#This sends an HTTP request to fetch the supplier
supplierStr = Net::HTTP.get_response(URI.parse(supplierURL))
supplierData = supplierStr.body
#This parses the body of the http JSON response to a ruby object
supplierHash = JSON.parse(supplierData)
#This prints the supplier name
puts "Supplier ID: #{supplierHash["CompanyName"]}"

	