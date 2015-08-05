# features/place_page.feature

Feature: Place Page

	Background: User is signed and logged in
		Given User is signed in with username "pera", email "perin.mejl@gmail.com" and password "perapera"
		And User is logged in with email "perin.mejl@gmail.com" and password "perapera"
		And There are places

	Scenario: Viewing application's Place page
		Given There's a single place
		When User is on the places page
		Then He should see details about that place

	Scenario: Adding a new place
		When User is on the places page
		And He chooses to add new place
		Given User types informations about place
		When He creates a new place
		Then He should see details about that place

	Scenario: Editing existing place
		When User is on the places page
		And He chooses to edit a place
		Then He should have form fields filled with old informations
		Given User types informations about place
		When He updates that place with new informations
		Then He should see details about that place
