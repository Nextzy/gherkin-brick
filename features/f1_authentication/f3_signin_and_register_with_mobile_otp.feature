@epic_authentication
Feature: [Epic] Sign-in and Register with Mobile + OTP

  Background:
    Given the user is on the authentication page
    And the user is not logged in

  @story_signin @task_otp_verification
  Scenario: [Story] User wants to sign in with mobile OTP
    As a user
    I want to sign in using my mobile number and a one-time password
    So that I can access my account securely without remembering passwords

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

  @story_signin @task_error_handling
  Scenario: [Story] User wants to see appropriate error for invalid mobile number
    As a user
    I want to see clear error messages when I enter an invalid mobile number
    So that I can correct my input

    Given the user is on the sign-in page
    When the user selects the "Mobile + OTP" sign-in method
    And the user enters an invalid mobile number
    And the user clicks the "Send OTP" button
    Then the user should see an error message "Invalid mobile number"
    And remain on the sign-in page

  @story_signin @task_error_handling
  Scenario: [Story] User wants to see appropriate error for incorrect OTP
    As a user
    I want to see clear error messages when I enter an incorrect OTP
    So that I can correct my input or request a new OTP

    Given the user is on the sign-in page
    When the user selects the "Mobile + OTP" sign-in method
    And the user enters a valid registered mobile number
    And the user clicks the "Send OTP" button
    And the user enters an incorrect OTP
    And the user clicks the "Verify" button
    Then the user should see an error message "Invalid OTP"
    And remain on the sign-in page with the option to resend OTP

  @story_registration @task_otp_verification
  Scenario: [Story] User wants to register with mobile OTP
    As a new user
    I want to create an account using my mobile number
    So that I can access the platform securely using OTP authentication

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

  @story_registration @task_error_handling
  Scenario: [Story] User wants to see appropriate error for duplicate mobile
    As a user
    I want to be notified if my mobile number is already registered
    So that I can sign in with existing account instead

    Given the user is on the registration page
    When the user selects the "Mobile + OTP" registration method
    And the user enters a mobile number that is already registered
    And the user clicks the "Send OTP" button
    Then the user should see an error message "Mobile number already in use"
    And remain on the registration page

  @story_security @task_otp_expiration
  Scenario: [Story] User wants security for expired OTP
    As a security-conscious user
    I want OTPs to expire after a certain time
    So that my account remains secure even if my OTP is compromised

    Given the user has requested an OTP
    And the OTP has expired after the time limit
    When the user enters the expired OTP
    And the user clicks the "Verify" button
    Then the user should see an error message "OTP has expired"
    And the user should be prompted to request a new OTP

  @story_user_experience @task_resend_otp
  Scenario: [Story] User wants to request a new OTP
    As a user
    I want to be able to request a new OTP if needed
    So that I can complete the authentication process even if I didn't receive the first OTP

    Given the user is on the OTP verification screen
    When the user clicks the "Resend OTP" button
    Then a new OTP should be sent to the user's mobile number
    And the user should see a confirmation message "New OTP sent"