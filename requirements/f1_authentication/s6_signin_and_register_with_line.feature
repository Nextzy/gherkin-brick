@authentication @social @line
Feature: [Story] User wants to sign-in and register with Line
  As a user
  I want to be able to authenticate myself using my Line account
  So that I can access the platform securely without creating new credentials

  Background:
    Given the user is on the authentication page
    And the user is not logged in

  @signin @positive
  Scenario: Sign-in with Line
    Given the user is on the sign-in page
    When the user selects the "Sign in with Line" option
    Then the user should be redirected to the Line authentication page
    When the user successfully authenticates with their Line account
    And grants the necessary permissions
    Then the user should be redirected back to the application
    And the user should be successfully authenticated
    And redirected to the dashboard

  @signin @negative
  Scenario: Sign-in with Line - authentication cancelled
    Given the user is on the sign-in page
    When the user selects the "Sign in with Line" option
    Then the user should be redirected to the Line authentication page
    When the user cancels the Line authentication
    Then the user should be redirected back to the application
    And the user should see a message "Authentication cancelled"
    And remain on the sign-in page

  @register @positive
  Scenario: Register with Line (first time)
    Given the user is on the registration page
    When the user selects the "Sign up with Line" option
    Then the user should be redirected to the Line authentication page
    When the user successfully authenticates with their Line account
    And grants the necessary permissions
    And the Line account is not associated with an existing user
    Then a new account should be created using the Line profile information
    And the user should be successfully authenticated
    And redirected to the onboarding flow

  @signin @negative
  Scenario: Sign-in with Line - account does not exist
    Given the user is on the sign-in page
    When the user selects the "Sign in with Line" option
    Then the user should be redirected to the Line authentication page
    When the user successfully authenticates with their Line account
    And grants the necessary permissions
    And the Line account is not associated with an existing user
    Then the user should see a message "No account found with this Line account"
    And be prompted to register

  @permissions @negative
  Scenario: Sign-in with Line - insufficient permissions
    Given the user is on the sign-in page
    When the user selects the "Sign in with Line" option
    Then the user should be redirected to the Line authentication page
    When the user successfully authenticates with their Line account
    But declines to grant the necessary permissions
    Then the user should be redirected back to the application
    And the user should see an error message "Insufficient permissions"
    And remain on the sign-in page