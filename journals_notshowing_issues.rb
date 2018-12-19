require "net/http"
require "uri"
require "json"

uri = URI.parse("http://oscar-the-penguin.live.cf.private.springer.com/v1/product/?migrationState=mosaic")
hub_uri = URI.parse("http://hub.nature.com/api/v1/journals?include=hasCurrentIssue&page=1&pageSize=200&domain=nature&client=jordy")

hub_response = Net::HTTP.get_response(hub_uri)
penguin_response = Net::HTTP.get_response(uri)

hub_data = JSON.parse(hub_response.body) 
data = JSON.parse(penguin_response.body) 

journals = hub_data["journals"]

journals_with_current_issue = journals.select do |journal| 
	journal if journal.keys.include? 'hasCurrentIssue'
end

pcodes_for_journals_with_current_issue = journals_with_current_issue.collect do |journal| 
	journal['id']
end

data.each do |hashchild| 

	x = hashchild.select { |k, v| ["pcode", "publishesIssues"].include? k} 

	if x['publishesIssues']

	else
		if pcodes_for_journals_with_current_issue.include?(x['pcode'])
					puts x['pcode']

		end
	end

end

