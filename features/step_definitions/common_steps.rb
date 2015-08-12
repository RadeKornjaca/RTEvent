
Then(/^he should see alert asking "(.*?)"$/) do |msg|
  message = page.driver.browser.switch_to.alert.text
  expect(message).to eq(msg)
end

When(/^user confirms deletion$/) do
  page.driver.browser.switch_to.alert.accept
end

When(/^user is logged in$/) do
  @user = FactoryGirl.create(:user)

  visit new_user_session_path

  fill_in "user_email", :with => @user.email
  fill_in "user_password", :with => @user.password

  click_button "Login"
end
