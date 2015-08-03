# features/step_definitions/signup_login_steps.rb


Given(/^user is signed in with username "(.*?)", email "(.*?)" and password "(.*?)"$/) do |username, email, password|
	@user = FactoryGirl.create(:user, email: email, username: username, password: password)
end

Given(/^User "(.*?)" is logged in$/) do |username|
	@user = User.find_by_username(username)
	
	visit '/users/sign_in'
  fill_in "user_email", :with => @user.email
  fill_in "user_password", :with => @user.password
  click_button "Login"
end
