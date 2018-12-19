require "net/http"
require "uri"
require "json"

uri = URI.parse("http://oscar-the-penguin.live.cf.private.springer.com/v1/product/?migrationState=mosaic")
penguin_response = Net::HTTP.get_response(uri)
data = JSON.parse(penguin_response.body) 

# x = data.map { |s| {journal: s["pcode"], pubishing: s["publishesIssues"]}}

data.each do |hashchild| 

	x = hashchild.select { |k, v| ["pcode", "publishesIssues"].include? k} 

	if x['publishesIssues']
	
	else
		puts x["pcode"]
    end
end
