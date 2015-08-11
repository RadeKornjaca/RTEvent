
Then(/^he should see alert asking "(.*?)"$/) do |msg|
  message = page.driver.browser.switch_to.alert.text
  expect(message).to eq(msg)
end

When(/^user confirms deletion$/) do
  page.driver.browser.switch_to.alert.accept
end
