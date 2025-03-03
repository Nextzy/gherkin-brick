@authentication @mobile @otp
Feature: [Story] User wants to sign-in and register with mobile + OTP
  As a user
  I want to be able to authenticate myself using my mobile number and OTP
  So that I can access the platform securely without remembering passwords

  Background:
    Given the user is on the authentication page
    And the user is not logged in

  @signin @positive
  Scenario: Sign-in with mobile + OTP
    Given the user is on the sign-in page
    When the user selects the "Mobile + OTP" sign-in method
    And the user enters a valid registered mobile number
    And the user clicks the "Send OTP" button
    Then an OTP should be sent to the user's mobile number
    And the user should see an OTP input field
    When the user enters the correct OTP
    And the user clicks the "Verify" button
    Then the user should be successfully authenticated
    And redirected to the dashboard

  @signin @negative
  Scenario: Sign-in with invalid mobile number
    Given the user is on the sign-in page
    When the user selects the "Mobile + OTP" sign-in method
    And the user enters an invalid mobile number
    And the user clicks the "Send OTP" button
    Then the user should see an error message "Invalid mobile number"
    And remain on the sign-in page

  @signin @negative
  Scenario: Sign-in with invalid OTP
    Given the user is on the sign-in page
    When the user selects the "Mobile + OTP" sign-in method
    And the user enters a valid registered mobile number
    And the user clicks the "Send OTP" button
    And the user enters an incorrect OTP
    And the user clicks the "Verify" button
    Then the user should see an error message "Invalid OTP"
    And remain on the sign-in page with the option to resend OTP

  @register @positive
  Scenario: Register with mobile + OTP
    Given the user is on the registration page
    When the user selects the "Mobile + OTP" registration method
    And the user enters a valid mobile number that is not already registered
    And the user clicks the "Send OTP" button
    Then an OTP should be sent to the user's mobile number
    And the user should see an OTP input field
    When the user enters the correct OTP
    And the user clicks the "Verify" button
    Then a new account should be created
    And the user should be successfully authenticated
    And redirected to the onboarding flow

  @register @negative
  Scenario: Register with mobile number that is already in use
    Given the user is on the registration page
    When the user selects the "Mobile + OTP" registration method
    And the user enters a mobile number that is already registered
    And the user clicks the "Send OTP" button
    Then the user should see an error message "Mobile number already in use"
    And remain on the registration page

  @security
  Scenario: OTP expiration
    Given the user has requested an OTP
    And the OTP has expired after the time limit
    When the user enters the expired OTP
    And the user clicks the "Verify" button
    Then the user should see an error message "OTP has expired"
    And the user should be prompted to request a new OTP

  @usability
  Scenario: Resend OTP
    Given the user is on the OTP verification screen
    When the user clicks the "Resend OTP" button
    Then a new OTP should be sent to the user's mobile number
    And the user should see a confirmation message "New OTP sent"