
When(/^there is a place$/) do
	@random_place = FactoryGirl.create(:place, place_name: Faker::Company.name, address: Faker::Address.street_address)
end

And(/^there's a single event$/) do
	fake_time = Faker::Time.between(DateTime.now - 7, DateTime.now + 7, :all)

	@event = FactoryGirl.create(:event, 
              :title => Faker::Name.title, 
              :starts_at => fake_time,
              :place => @random_place, 
              :user => @user,
              :description => Faker::Lorem.sentence
           )
end

When(/^user is on the events page$/) do
	visit events_path
end

Then(/^he should see details about that event$/) do
	expect(page).to have_content(@event.title)
	expect(page).to have_content(@event.description)
end


When(/^user is on that event's page$/) do
	visit event_path(@event)
end

Then(/^he should see detailed information about that event$/) do
	expect(page).to have_content(@event.title)
	#expect(page).to have_content(@event.starts_at.to_date != Date.today ? @event.starts_at.strftime("%A, %B %d, %Y") : distance_of_time_in_words(Time.now, @event.starts_at))
	expect(page).to have_content(@event.place.place_name)
	expect(page).to have_content(@event.description)
end

Given(/^there are events$/) do
	@events = []

  random_user = User.all[0]
	random_place = Place.all[0]	

  4.times do
	  @events << FactoryGirl.create(:event,
                 :title => Faker::Name.title, 
                 :starts_at => Faker::Time.between(DateTime.now - 7, DateTime.now + 7),
                 :user => @user, 
                 :place => random_place, 
                 :description => Faker::Lorem.sentence
               )
  end
end

When(/^user is on a events page$/) do
	visit events_path
end

When(/^new event$/) do
  visit new_event_path
end

When(/^he chooses "(.*?)"$/) do |option|
  click_link option
end

When(/^he chooses "(.*?)" link$/) do |option|
  within "#event_" << @event.id.to_s do
	  click_link option
  end
end

Then(/^user should be redirected to a new event form page$/) do
	current_path.should == new_event_path
end

Then(/^user should be redirected to a edit event form page$/) do
	current_path.should == edit_event_path(@events[0].id) 
end

Given(/^user fills up information about event$/) do	
	fake_time = Faker::Time.between(DateTime.now - 7, DateTime.now + 7, :all)

	@event = FactoryGirl.build(:event, 
              :title => Faker::Name.title, 
              :starts_at => fake_time,
              :place => @random_place, 
              :user => @user,
              :description => Faker::Lorem.sentence
           )

	fill_in "event_title", :with => @event.title
	within "#starts_at"  do	
		select fake_time.year, :from => "event_starts_at_1i" 
		select fake_time.strftime("%B"), :from => "event_starts_at_2i" 
		select fake_time.day, :from => "event_starts_at_3i" 
		select date_form_format(fake_time.hour), :from => "event_starts_at_4i" 
		select date_form_format(fake_time.min), :from => "event_starts_at_5i" 	
	end
  select @event.place.place_name, from: "event_place_id"
	fill_in "event_description", :with => @event.description
	first("input#event_user_id", :visible => false).set @user.id
end

Given(/^he chooses button "(.*?)"$/) do |option|
	click_button option 
end

Then(/^he should see detailed page about event$/) do
	expect(page).to have_content(@event.title)
	expect(page).to have_content(@event.description)
end

Then(/^event should be deleted from database$/) do
  sleep(1)                                          # otherwise, line bellow will fail even when it shouldn't
  expect(Event.where(:id => @event.id).blank?).to eq true
end

When(/^he chooses to edit an event$/) do
  within "#event_" << @events[0].id.to_s do
    click_link "Edit"
  end
end

Then(/^should see form filled with old information about event$/) do
  pending # express the regexp above with the code you wish you had
end

def date_form_format num
  num < 10 ? "0" << num.to_s : num.to_s
end
