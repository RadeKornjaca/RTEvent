# features/step_definitions/signup_login_steps.rb


Given(/^user is signed in with username "(.*?)", email "(.*?)" and password "(.*?)"$/) do |username, email, password|
	@user = FactoryGirl.create(:user, email: email, username: username, password: password)
end

Given(/^User is logged in with email "(.*?)" and password "(.*?)"$/) do |email, password|
	visit '/users/sign_in'
	fill_in "user_email", :with => email
	fill_in "user_password", :with => password
	click_button "Login"
end
