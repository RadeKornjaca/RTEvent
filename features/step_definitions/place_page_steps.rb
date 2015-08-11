# features/step_definitions/place_page_steps.rb

Given(/^there are places$/) do
  @places = []	
  4.times do
    @places << FactoryGirl.create(:place, 
                                  :place_name => Faker::Name.title, 
                                  :address => Faker::Address.street_address
                                 )
  end
end

Given(/^there's a single place$/) do
  @place = FactoryGirl.create(:place)
end

When(/^user is on the places page$/) do
  visit "/places"
end

When(/^he chooses to add new place$/) do
  click_link "New Place"
end

Given(/^user types informations about place$/) do
  @place = FactoryGirl.build(:place, 
                             :place_name => Faker::Name.title,
                             :address => Faker::Address.street_address
                            )
  fill_in "place_place_name", :with => @place.place_name
  fill_in "place_address", :with => @place.address
end

When(/^he creates a new place$/) do
  click_button 'Create Place'
end

Then(/^he should see details about that place$/) do
  expect(page).to have_content(@place.place_name)
  expect(page).to have_content(@place.address)
end

When(/^he chooses to "(.*?)" a place$/) do |option|
  within("tr#place_" << @place.id.to_s) do
    click_link option
  end
end

Then(/^he should have form fields filled with old informations$/) do
  expect(current_path).to eq('/places/' << @place.id.to_s << '/edit') 
 
  expect(find_field("place_place_name").value).to have_content(@place.place_name)
  expect(find_field("place_address").value).to have_content(@place.address)

end

When(/^he updates that place with new informations$/) do
  @place = FactoryGirl.create(:place,
                              :place_name => Faker::Company.name, 
                              :address => Faker::Address.street_address
                             )
  
  fill_in "place_place_name", :with => @place.place_name
  fill_in "place_address", :with => @place.address  
  
  click_button 'Update Place'
end

Then(/^place shouldn't be in database anymore$/) do
  sleep(1)                                          # otherwise, line bellow will fail even when it shouldn't
  expect(Place.where(:id => @place.id).blank?).to eq true
end







