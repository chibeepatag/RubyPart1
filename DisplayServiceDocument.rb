#This includes the source code to make http requests
require 'net/http'
#This includes the source code to parse JSON responses to ruby objects
require 'json'

#This is the url to get the table names and its url in json format
url = "http://services.odata.org/Northwind/Northwind.svc/?$format=json"
#This line prints the label and the url
puts "Northwind Collections from " + url + "."
#This prints a carriage return to add a space.
puts "\r"

# Make an HTTP request and place the result in jsonStr
jsonStr = Net::HTTP.get_response(URI.parse(url))

#Assigns the body attribute of jsonStr to the variable data
data = jsonStr.body

#This parses data into a ruby object
jsonHash = JSON.parse(data)

#Iterates through the values of jsonHash and prints the name value
jsonHash["value"].each do | item |
	puts item["name"]
end