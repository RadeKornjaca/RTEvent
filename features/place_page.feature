# features/place_page.feature

Feature: Place Page

  Background: User is signed and logged in
    Given user is signed in with username "pera", email "perin.mejl@gmail.com" and password "perapera"
    And user is logged in with email "perin.mejl@gmail.com" and password "perapera"
    And there are places

  Scenario: Viewing application's Place page
    Given there's a single place
    When user is on the places page
    Then he should see details about that place

  Scenario: Adding a new place
    When user is on the places page
    And he chooses to add new place
    Given user types informations about place
    When he creates a new place
    Then he should see details about that place

  Scenario: Editing existing place
    When user is on the places page
    And he chooses to edit a place
    Then he should have form fields filled with old informations
    Given user types informations about place
    When he updates that place with new informations
    Then he should see details about that place
