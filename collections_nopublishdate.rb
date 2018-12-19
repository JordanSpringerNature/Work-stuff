
require 'json'

file = File.open('publicationdate_coll')
parsed_json = JSON.load(file)

puts parsed_json


file = File.open('test.csv', 'w')

parsed_json['collections'].each do |collection|

 has_journal_id = ''
 has_journal_id = collection['hasJournal']['id'] if collection['hasJournal']

 file.puts collection['id'] + ',' + collection['title'] + ',' + has_journal['id']
end




