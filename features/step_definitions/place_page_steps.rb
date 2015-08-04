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
