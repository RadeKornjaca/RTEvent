# features/home_page.feature

Feature: Home Page

	Scenario: Viewing application's Home page
		Given There's a post titled Hot events with "events"
		When I am on the homepage
		Then I should see events that are happening after "now" 
