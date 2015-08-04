# features/step_definitions/place_page_steps.rb

Given(/^There's a single place$/) do
	@place = FactoryGirl.create(:place)

end

When(/^I am on the places page$/) do
	visit "/places"
end

Then(/^I should see details about that "(.*?)"$/) do |place_name|
	@place = Place.find_by_place_name(place_name)
	expect(page).to have_content(@place.place_name)
	expect(page).to have_content(@place.address)
end

When(/^User is on the places page$/) do
	visit '/places'
end

When(/^He chooses to add new place$/) do
	click_link 'New Place'
end

Given(/^User types informations about place$/) do
	@place = FactoryGirl.build(:place, place_name: Faker::Name.title, address: Faker::Address.street_address)
	fill_in "place_place_name", :with => @place.place_name
	fill_in "place_address", :with => @place.address
end

When(/^He creates a new place$/) do
	click_button 'Create Place'
end

Then(/^He should see details about newly added place$/) do
	expect(page).to have_content(@place.place_name)
	expect(page).to have_content(@place.address)
end

