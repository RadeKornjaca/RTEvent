# features/step_definitions/place_page_steps.rb

Given(/^There are places$/) do
	@places = []	
	1.times do
		@places << FactoryGirl.create(:place, place_name: Faker::Name.title, address: Faker::Address.street_address)
	end
end

Given(/^There's a single place$/) do
	@place = FactoryGirl.create(:place)

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

Then(/^He should see details about that place$/) do
	expect(page).to have_content(@place.place_name)
	expect(page).to have_content(@place.address)
end

When(/^He chooses to edit a place$/) do
	save_and_open_page
	find(:xpath, '//a[text="Edit"][0]').click	
	#click_link 'Edit'
end

Then(/^He should have form fields filled with old informations$/) do
	page.has_content?(@places[0].place_name)
	page.has_content?(@places[0].address)
end

When(/^He updates that place with new informations$/) do
	click_button 'Update Place'
end

