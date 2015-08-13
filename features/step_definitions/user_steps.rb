
Given(/^user is on the homepage$/) do
  visit root_path
end

Given(/^user exists$/) do
  @user = FactoryGirl.create(:user)
end

When(/^he chooses to sign in$/) do
  click_link "Login"
end

When(/^he fills up form with his email and password$/) do
  fill_in "user_email", :with => @user.email
  fill_in "user_password", :with => @user.password
end

When(/^clicks Sign in button$/) do
  click_button "Login"
end

Then(/^he should see "(.*?)" message$/) do |msg|
  expect(page).to have_content(msg)
end

Given(/^user do not exist$/) do
  username = Faker::Internet.user_name
  @user = FactoryGirl.build(:user, :username => username, :email => Faker::Internet.email(username), :password => Faker::Internet.password(8))
end

When(/^he presses the Sign Up button$/) do
  click_link "Sign up"
end

Then(/^he should see sign up form$/) do
  expect(current_path).to eq(new_user_registration_path)
end

Then(/^fill all of the required information$/) do
  fill_in "user_email", :with => @user.email
  fill_in "user_username", :with => @user.username
  fill_in "user_password", :with => @user.password
  fill_in "user_password_confirmation", :with => @user.password
end

When(/^he presses Sign Up button$/) do
  click_button "Sign up"
end

Then(/^he should stay on the Sign Up page and see the message what's wrong$/) do 
  expect(current_path).to eq(user_registration_path)
  expect(page).to have_content("Please review the problems below:")
end

Then(/^he should stay on the Sign in page$/) do
  expect(current_path).to eq(user_session_path)
end
