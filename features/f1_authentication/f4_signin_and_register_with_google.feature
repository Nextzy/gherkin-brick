Feature: Sign-in and Register with Google
  As a user
  I want to be able to authenticate myself using my Google account
  So that I can access the platform securely without creating new credentials

  Background:
    Given the user is on the authentication page
    And the user is not logged in

  Scenario: Sign-in with Google
    Given the user is on the sign-in page
    When the user selects the "Sign in with Google" option
    Then the user should be redirected to the Google authentication page
    When the user successfully authenticates with their Google account
    And grants the necessary permissions
    Then the user should be redirected back to the application
    And the user should be successfully authenticated
    And redirected to the dashboard

  Scenario: Sign-in with Google - authentication cancelled
    Given the user is on the sign-in page
    When the user selects the "Sign in with Google" option
    Then the user should be redirected to the Google authentication page
    When the user cancels the Google authentication
    Then the user should be redirected back to the application
    And the user should see a message "Authentication cancelled"
    And remain on the sign-in page

  Scenario: Register with Google (first time)
    Given the user is on the registration page
    When the user selects the "Sign up with Google" option
    Then the user should be redirected to the Google authentication page
    When the user successfully authenticates with their Google account
    And grants the necessary permissions
    And the Google account is not associated with an existing user
    Then a new account should be created using the Google profile information
    And the user should be successfully authenticated
    And redirected to the onboarding flow

  Scenario: Sign-in with Google - account does not exist
    Given the user is on the sign-in page
    When the user selects the "Sign in with Google" option
    Then the user should be redirected to the Google authentication page
    When the user successfully authenticates with their Google account
    And grants the necessary permissions
    And the Google account is not associated with an existing user
    Then the user should see a message "No account found with this Google account"
    And be prompted to register

  Scenario: Sign-in with Google - insufficient permissions
    Given the user is on the sign-in page
    When the user selects the "Sign in with Google" option
    Then the user should be redirected to the Google authentication page
    When the user successfully authenticates with their Google account
    But declines to grant the necessary permissions
    Then the user should be redirected back to the application
    And the user should see an error message "Insufficient permissions"
    And remain on the sign-in page