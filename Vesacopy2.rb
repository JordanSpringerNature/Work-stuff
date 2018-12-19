require "rubygems"
require "json"
require "net/http"
require "uri"

uri = URI.parse("http://hub.nature.com/api/v1/journals/?client=jordy&domain=nature&pageSize=200")

http = Net::HTTP.new(uri.host, uri.port)
request = Net::HTTP::Get.new(uri.request_uri)
response = http.request(request)

if response.code == "200"
  begin
      
    result = JSON.parse(response.body)

  rescue Exception => e
    puts "Unable to parse json: #{e}"
    exit 1
  end 

  pcodes = result["journals"].map { |journal| journal["id"] } 

  map_of_things = {}

  pcodes.each do |pcode|
    uri = URI.parse("http://oscar-the-penguin.live.cf.private.springer.com/v1/furniture/") + (pcode)
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Get.new(uri.request_uri)
    response = http.request(request)

    if response.code == "200"

      begin
        items = JSON.parse(response.body)
      rescue Exception => e
        puts "Unable to parse json for #{pcode}: #{e}" 
      end 

      slugs_of_interest = []

      items["navigationItems"].each do |navitem| 
        if navitem["group"] == "static" 
          slugs_of_interest << navitem
        end 
      end

      map_of_things[pcode] = slugs_of_interest.count
    else
      puts "HTTP error #{response.code} requesting pcode #{pcode}."
    end
  end

 sortedlist = map_of_things.partition { |key, val| val == 0 }

#  sortedlist2 = sortedlist.group_by  { |number| number[0] }

  puts sortedlist


else
  puts "HTTP error #{response.code} requesting journal list from Nature Hub."

end