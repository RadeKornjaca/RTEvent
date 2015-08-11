# features/step_definitions/home_page_steps.rb

Given(/^There's a post titled Hot Events with "(.*?)"/) do ||

end

When(/^I am on the homepage/) do
  visit "/"
end

Then(/^I should see events that are happening after "(.*?)"/) do

end

Then(/^events should be sorted in ascending order$/) do
  titles = Event.order("starts_at desc").pluck(:title)
end
