@authentication @email @password
Feature: [Story] User wants to sign-in and register with email and password
  As a user
  I want to be able to authenticate myself using email and password
  So that I can access the platform securely

  Background:
    Given the user is on the authentication page
    And the user is not logged in

  @signin @positive
  Scenario: Sign-in with email and password
    Given the user is on the sign-in page
    When the user selects the "Email & Password" sign-in method
    And the user enters a valid email address
    And the user enters a valid password
    And the user clicks the "Sign In" button
    Then the user should be successfully authenticated
    And redirected to the dashboard

  @signin @negative
  Scenario: Sign-in with invalid email and password
    Given the user is on the sign-in page
    When the user selects the "Email & Password" sign-in method
    And the user enters an invalid email address or password
    And the user clicks the "Sign In" button
    Then the user should see an error message "Invalid email or password"
    And remain on the sign-in page

  @register @positive
  Scenario: Register with email and password
    Given the user is on the registration page
    When the user selects the "Email & Password" registration method
    And the user enters a valid email address that is not already registered
    And the user enters a valid password that meets the password requirements
    And the user confirms the password
    And the user clicks the "Register" button
    Then a new account should be created
    And the user should be successfully authenticated
    And redirected to the onboarding flow

  @register @negative
  Scenario: Register with email that is already in use
    Given the user is on the registration page
    When the user selects the "Email & Password" registration method
    And the user enters an email address that is already registered
    And the user enters a valid password
    And the user confirms the password
    And the user clicks the "Register" button
    Then the user should see an error message "Email already in use"
    And remain on the registration page

  @recovery
  Scenario: Password recovery
    Given the user is on the sign-in page
    When the user clicks on the "Forgot Password" link
    And the user enters their registered email address
    And the user clicks the "Reset Password" button
    Then a password reset link should be sent to the user's email address
    And the user should see a confirmation message
    When the user clicks the password reset link from their email
    And the user enters a new valid password
    And the user confirms the new password
    And the user clicks the "Update Password" button
    Then the user's password should be updated
    And the user should be redirected to the sign-in page with a success message

  @security
  Scenario: Account lockout after multiple failed attempts
    Given the user is on the sign-in page
    When the user attempts to sign in with incorrect credentials 5 consecutive times
    Then the user's account should be temporarily locked
    And the user should see an error message indicating the account is locked
    And the user should be provided with account recovery options