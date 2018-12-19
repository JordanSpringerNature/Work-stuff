require "net/http"
require "uri"
require "json"

hub_uri = URI.parse("http://hub.nature.com/api/v1/journals?include=hasCurrentIssue&page=1&pageSize=200&domain=nature&client=jordy")
hub_response = Net::HTTP.get_response(hub_uri)
hub_data = JSON.parse(hub_response.body) 

journals = hub_data["journals"]

journals_with_current_issue = journals.select do |journal| 
	journal if journal.keys.include? 'hasCurrentIssue'
end

pcodes_for_journals_with_current_issue = journals_with_current_issue.collect do |journal| 
	journal['id']
end

pp pcodes_for_journals_with_current_issue.count



#journals.each do {|key, value|} 
#	if key == "id" 
#		puts value
#	end
#end



