
Feature: Events Page

  Background: User is signed and logged in
    When user is logged in 
    And there are a few places
    And there are events happening on them

  Scenario: Viewing application's Events page
    Given there's a single event
    When user is on the events page
    Then he should see details about that event

  Scenario: Viewing application's single event page
    Given there's a single event
    When user is on that event's page
    Then he should see detailed information about that event

  Scenario: Making new event
    When user is on a events page
    And he chooses "New Event" 
    Then user should be redirected to a new event form page
    Given user fills up information about event
    And he chooses button "Create Event"
    Then he should see detailed page about event

  Scenario: Editing existing event
    When user is on a events page
    And he chooses to edit an event
    Then user should be redirected to a edit event form page
    And should see form filled with old information about event
    Given user fills up information about event
    And he chooses button "Update Event"
    Then he should see detailed page about event

  @javascript
  Scenario: Deleting an event
    Given there's a single event
    When user is on the events page
    And he chooses "Delete" link
    Then he should see alert asking "Are you sure?"
    When user confirms deletion
    Then event should not be seen anymore 
