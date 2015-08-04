# features/place_page.feature

Feature: Place Page

	Background: User is signed and logged in
		Given user is signed in with username "pera", email "perin.mejl@gmail.com" and password "perapera"
		And User is logged in with email "perin.mejl@gmail.com" and password "perapera"

	Scenario: Viewing application's Place page
		Given There's a single place
		When I am on the places page
		Then I should see details about that "Alternativa" 
