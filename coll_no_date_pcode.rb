require "rubygems" 
require "selenium-webdriver"

no_pub_date = File.open("nopubdate").read
no_pub_date = gsub!("\n")
ndc = no_pub_date.split("\n")

puts ndc.count

file = File.open('test.csv', 'w')

driver = Selenium::WebDriver.for :chrome

count = 0

ndc.each do |line|	 
  address = "http://hub-api.live.cf.private.springer.com/api/v1" + line.split("'")[0] + "?domain=nature&client=jordan"
  driver.navigate.to address
  if  has_journal_id != ''
    has_journal_id = collection['hasJournal']['id'] if collection['hasJournal']
    file.puts collection['id'] + ',' + has_journal['id']
    count = count +1
  end
end

puts count




