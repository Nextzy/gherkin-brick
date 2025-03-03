@authentication @social @facebook
Feature: [Story] User wants to sign-in and register with Facebook
  As a user
  I want to be able to authenticate myself using my Facebook account
  So that I can access the platform securely without creating new credentials

  Background:
    Given the user is on the authentication page
    And the user is not logged in

  @signin @positive
  Scenario: Sign-in with Facebook
    Given the user is on the sign-in page
    When the user selects the "Sign in with Facebook" option
    Then the user should be redirected to the Facebook authentication page
    When the user successfully authenticates with their Facebook account
    And grants the necessary permissions
    Then the user should be redirected back to the application
    And the user should be successfully authenticated
    And redirected to the dashboard

  @signin @negative
  Scenario: Sign-in with Facebook - authentication cancelled
    Given the user is on the sign-in page
    When the user selects the "Sign in with Facebook" option
    Then the user should be redirected to the Facebook authentication page
    When the user cancels the Facebook authentication
    Then the user should be redirected back to the application
    And the user should see a message "Authentication cancelled"
    And remain on the sign-in page

  @register @positive
  Scenario: Register with Facebook (first time)
    Given the user is on the registration page
    When the user selects the "Sign up with Facebook" option
    Then the user should be redirected to the Facebook authentication page
    When the user successfully authenticates with their Facebook account
    And grants the necessary permissions
    And the Facebook account is not associated with an existing user
    Then a new account should be created using the Facebook profile information
    And the user should be successfully authenticated
    And redirected to the onboarding flow

  @signin @negative
  Scenario: Sign-in with Facebook - account does not exist
    Given the user is on the sign-in page
    When the user selects the "Sign in with Facebook" option
    Then the user should be redirected to the Facebook authentication page
    When the user successfully authenticates with their Facebook account
    And grants the necessary permissions
    And the Facebook account is not associated with an existing user
    Then the user should see a message "No account found with this Facebook account"
    And be prompted to register

  @permissions @negative
  Scenario: Sign-in with Facebook - insufficient permissions
    Given the user is on the sign-in page
    When the user selects the "Sign in with Facebook" option
    Then the user should be redirected to the Facebook authentication page
    When the user successfully authenticates with their Facebook account
    But declines to grant the necessary permissions
    Then the user should be redirected back to the application
    And the user should see an error message "Insufficient permissions"
    And remain on the sign-in page