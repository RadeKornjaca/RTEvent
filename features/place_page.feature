Feature: Place Page

  Background: User is logged in
    When user is logged in 
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
    Then he shouldn't see it anymore
