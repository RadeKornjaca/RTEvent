# features/events_page.feature

Feature: Events Page

	Background: User is signed and logged in
		Given user is signed in with username "zika", email "zikin.mejl@gmail.com" and password "zikazika"
		And User is logged in with email "zikin.mejl@gmail.com" and password "zikazika"

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

	Scenario: User makes new event
		Given User makes new event		
		When User is on a new event page
		Then New event should be seen with other events
