# features/place_page.feature

Feature: Place Page

	Scenario: Viewing application's Place page
		Given There's a single place
		And user is signed and logged in with username "pera", email "perin.mejl@gmail.com" and password "perapera"
		When I am on the places page
		Then I should see details about that "Alternativa" 
