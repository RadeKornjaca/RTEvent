# features/step_definitions/event_page_steps.rb

#require 'faker'

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
	#expect(page).to have_content(@event.starts_at.to_date != Date.today ? @event.starts_at.strftime("%A, %B %d, %Y") : distance_of_time_in_words(Time.now, @event.starts_at))
	expect(page).to have_content(@event.place.place_name)
	expect(page).to have_content(@event.description)
end

Given(/^There are a few events$/) do
  @events = []
	@events << FactoryGirl.create(:event)

	random_user = User.all[0]				# FIXME: hard coded
	random_place = Place.all[0]	

	@events << FactoryGirl.create(:event, title: Faker::Name.title, starts_at: Faker::Time.between(DateTime.now - 7, DateTime.now + 7), user: random_user, place: random_place, description: Faker::Hacker.say_something_smart)
end

Then(/^Events should be sorted in ascending order$/) do
  ( Event.all.sort == @events ).should be true
end


