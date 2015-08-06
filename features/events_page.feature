# features/events_page.feature

Feature: Events Page

	Background: User is signed and logged in
		Given user is signed in with username "zika", email "zikin.mejl@gmail.com" and password "zikazika"
		And user is logged in with email "zikin.mejl@gmail.com" and password "zikazika"

	Scenario: Viewing application's Events page
		Given There's a single event
		When I am on the events page
		Then I should see details about that event titled "Zurka"

	Scenario: Viewing application's single event page
		Given There's a single event
		When I am on that event's page
		Then I should see detailed stuff about event "Zurka"

	Scenario: All events in ascending order
		Given There are a few events
		When I am on the events page
		Then Events should be sorted in ascending order

	Scenario: Making new event
		When User is on a events page
		And He chooses to make a new event
		Then User should be redirected to a new event page
		Given User fills up information about new event
		And Chooses to add newly created event
		Then He should see details about newly added event
