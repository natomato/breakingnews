require 'open-uri'

Given /^I am not yet viewing the breakingnews page$/ do
end

When /^I navigate to the site$/ do
  visit root_url
end

Then /^I should see (\d+) headlines from "([^"]*)"$/ do |num, domain|
  source = Nokogiri::HTML(open('http://' + domain))
  # latest_headline should appear on root_url page
end

Then /^I should see the first paragraph of the story$/ do

end


#--------------------------------------------------------

Given /^I am viewing the breakingnews page$/ do
  visit root_url
end

When /^A news story is posted on "([^"]*)"$/ do |domain|
  news = Nokogiri::HTML(open('http://' + domain))

end

Then /^I should see the story on the page$/ do
end
