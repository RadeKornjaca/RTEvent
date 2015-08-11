# features/place_page.feature

Feature: Place Page

  Background: User is signed and logged in
    Given user exists
    And user is on the homepage
    When he chooses to sign in
    And he fills up form with his email and password
    And clicks Sign in button    
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
    Given there's a single place
    When user is on the places page
    And he chooses to "Edit" a place
    Then he should have form fields filled with old informations
    Given user types informations about place
    When he updates that place with new informations
    Then he should see details about that place

  @javascript
  Scenario: Deleting a place 
    Given there's a single place
    When user is on the places page
    And he chooses to "Destroy" a place
    Then he should see alert asking "Are you sure?"
    When user confirms deletion
    Then place shouldn't be in database anymore
