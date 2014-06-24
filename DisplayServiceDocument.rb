require 'net/http'
require 'json'

url = "http://services.odata.org/Northwind/Northwind.svc/?$format=json"
puts "Northwind Collections from " + url + "."
puts "\r"

# Make an HTTP request and place the result in jsonStr

jsonStr = Net::HTTP.get_response(URI.parse(url))

data = jsonStr.body

jsonHash = JSON.parse(data)


jsonHash["value"].each do | item |
	puts item["name"]

end