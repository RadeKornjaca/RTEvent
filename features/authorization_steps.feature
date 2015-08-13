Feature: Sign up and Sign in mechanisms

  Background: Be sure that user is on the homepage
    Given user is on the homepage

  Scenario: User signs in
    Given user exists
    When he chooses to sign in
    And he fills up form with his email and password
    And clicks Sign in button
    Then he should see "Signed in successfully." message

  Scenario: Non-existing user tries to sign up
    Given user do not exist
    When he chooses to sign in
    And he fills up form with his email and password
    And clicks Sign in button
    Then he should stay on the Sign in page

  Scenario: New user signs up
    Given user do not exist
    When he presses the Sign Up button
    Then he should see sign up form
    And fill all of the required information
    When he presses Sign Up button
    Then he should see "Welcome! You have signed up successfully." message

  Scenario: Existing user tries to sign up
    Given user exists
    When he presses the Sign Up button
    Then he should see sign up form
    And fill all of the required information
    When he presses Sign Up button
    Then he should stay on the Sign Up page and see the message what's wrong
