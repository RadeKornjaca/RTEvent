# features/step_definitions/event_page_steps.rb


And(/^There's a single event$/) do
	@event = FactoryGirl.create(:event)
end

When(/^I am on the events page$/) do
	visit '/events'
end

Then(/^I should see details about that event titled "(.*?)"$/) do |event_title|
	@event = Event.find_by_title(event_title)
  expect(page).to have_content(@event.title)
  expect(page).to have_content(@event.description)
end


When(/^I am on that event's page$/) do
	visit '/events/' + @event.id.to_s
end

Then(/^I should see detailed stuff about event "(.*?)"$/) do |title|
	@event = Event.find_by_title(title)

	expect(page).to have_content(@event.title)
	expect(page).to have_content(@event.starts_at)
	expect(page).to have_content(@event.place)
	expect(page).to have_content(@event.description)
end

