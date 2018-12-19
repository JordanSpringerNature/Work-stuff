require "rubygems" 
require "selenium-webdriver"

text = File.open('FT_coll_URLs').read
text.gsub!(/\r\n?/, "\n")
f3 = text.split("\n")

puts f3.count

driver = Selenium::WebDriver.for :chrome

count = 0

f3.each do |line|	 
  address = "https://www.nature.com" + line.split("'")[0]
  driver.navigate.to address
  if  address == driver.current_url 
    puts "original address: " + address
    puts "new address:      " + driver.current_url
    puts ""
    count = count +1
  end
end

puts count




