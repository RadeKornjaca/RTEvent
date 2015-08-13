When(/^there are a few places$/) do
  @random_places = []
  3.times do
    @random_places << FactoryGirl.create(:place, 
                                          place_name: Faker::Company.name, 
                                          address: Faker::Address.street_address
                                        )
  end
end

And(/^there's a single event$/) do
  fake_time = Faker::Time.between(DateTime.now - 7, DateTime.now + 7, :all)

  @event = FactoryGirl.create(:event, 
              :title => Faker::Name.title, 
              :starts_at => fake_time,
              :place => @random_places[rand(0..@random_places.size - 1)], 
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
  expect(page).to have_content(@event.place.place_name)
  expect(page).to have_content(@event.description)
end

Given(/^there are events happening on them$/) do
  @events = []

  4.times do
    @events << FactoryGirl.create(:event,
                 :title => Faker::Name.title, 
                 :starts_at => Faker::Time.between(DateTime.now - 7, DateTime.now + 7),
                 :user => @user, 
                 :place => @random_places[rand(0..@random_places.size - 1)], 
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
 expect(current_path).to eq(new_event_path)
end

Then(/^user should be redirected to a edit event form page$/) do
  current_path.should == edit_event_path(@events[0].id) 
end

Given(/^user fills up information about event$/) do 
  fake_time = Faker::Time.between(DateTime.now - 7, DateTime.now + 7, :all)

  @event = FactoryGirl.build(:event, 
              :title => Faker::Name.title, 
              :starts_at => fake_time,
              :place => @random_places[rand(0..@random_places.size - 1)], 
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
end

Given(/^he chooses button "(.*?)"$/) do |option|
  click_button option 
end

Then(/^he should see detailed page about event$/) do
  expect(page).to have_content(@event.title)
  expect(page).to have_content(@event.description)
end

Then(/^event should not be seen anymore$/) do
  expect(page).to have_no_content(@event.title)
end

When(/^he chooses to edit an event$/) do
  within "#event_" << @events[0].id.to_s do
    click_link "Edit"
  end
end

Then(/^should see form filled with old information about event$/) do
  expect(current_path).to eq(edit_event_path(@events[0].id))

  expect(find_field("event_title").value).to have_content(@events[0].title)

  expect(find("#event_starts_at_1i").value).to have_content(@events[0].starts_at.year)
  expect(find("#event_starts_at_2i").value).to have_content(@events[0].starts_at.month)
  expect(find("#event_starts_at_3i").value).to have_content(@events[0].starts_at.day)
  expect(find("#event_starts_at_4i").value).to have_content(date_form_format(@events[0].starts_at.hour))
  expect(find("#event_starts_at_5i").value).to have_content(date_form_format(@events[0].starts_at.min))

  expect(find_field("event_place_id").value).to have_content(@events[0].place_id)
  
  expect(find_field("event_description").value).to have_content(@events[0].description)
end

def date_form_format num
  num < 10 ? "0" << num.to_s : num.to_s
end
