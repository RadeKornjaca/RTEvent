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

When(/^User is on a events page$/) do
	visit '/events'
end

When(/^He chooses to make a new event$/) do
	@random_place = FactoryGirl.create(:place, place_name: Faker::Company.name, address: Faker::Address.street_address)
	click_link 'New Event'
end

Then(/^User should be redirected to a new event page$/) do
	current_path.should == "/events/new"
	
end

Given(/^User fills up information about new event$/) do	
	fake_time = Faker::Time.between(DateTime.now - 7, DateTime.now + 7, :all)

	@event = FactoryGirl.build(:event, title: Faker::Name.title, starts_at: fake_time, place: @random_place, user: @user, description: Faker::Lorem.sentence)

	fill_in "event_title", :with => @event.title
	within :xpath, '//form/div[@class = "field"][2]' do	
		select fake_time.year, from: "event_starts_at_1i" 
		select fake_time.strftime("%B"), from: "event_starts_at_2i" 
		select fake_time.day, from: "event_starts_at_3i" 
		select fake_time.hour, from: "event_starts_at_4i" 
		select fake_time.min, from: "event_starts_at_5i" 	
	end
	within :xpath, '//form/div[@class = "field"][3]' do		
		select @event.place.place_name, from: "event_place_id"
	end	
	fill_in "event_description", :with => @event.description
	find(:xpath, "//input[@id='event_user_id']").set @user.id
end

Given(/^Chooses to add newly created event$/) do
	click_button 'Create Event' 
end

Then(/^he should be redirected to detailed view of new event$/) do
	#TODO
end



