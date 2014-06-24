print "Enter Product ID "
productId = gets.chomp

require 'net/http'
require 'json'

url = "http://services.odata.org/Northwind/Northwind.svc/Products(#{productId})?$format=json"
jsonStr = Net::HTTP.get_response(URI.parse(url))

data = jsonStr.body
jsonHash = JSON.parse(data)

puts "Product ID:#{productId}"
puts "Product name: #{jsonHash["ProductName"]}"
puts "Supplier ID: #{jsonHash["SupplierID"]}"
puts "Active/Discontinued"
if (jsonHash["Discontinued"]) 
      puts jsonHash["ProductName"].to_s + " is a discontinued product"
   else 
      puts jsonHash["ProductName"].to_s + " is an active product"   
end

supplierURL = "http://services.odata.org/Northwind/Northwind.svc/Suppliers(#{jsonHash["SupplierID"]})?$format=json"
supplierStr = Net::HTTP.get_response(URI.parse(supplierURL))
supplierData = supplierStr.body
supplierHash = JSON.parse(supplierData)

puts "Supplier ID: #{supplierHash["CompanyName"]}"

	