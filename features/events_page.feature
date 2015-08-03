# features/events_page.feature

Feature: Events Page

	Background: Signing up and logging in
		Given user is signed in with username "zika", email "zikin.mejl@gmail.com" and password "zikazika"
		And User "zika" is logged in

	Scenario: Viewing application's Events page
		Given There's a single event
		When I am on the events page
		Then I should see details about that event titled "Zurka"

	Scenario: Viewing application's single event page
		Given There's a single event
		When I am on that event's page
		Then I should see detailed stuff about event "Zurka"
