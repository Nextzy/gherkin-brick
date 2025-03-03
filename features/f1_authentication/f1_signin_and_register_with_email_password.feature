@epic_authentication
Feature: [Epic] Sign-in and Register with Email and Password

  Background:
    Given the user is on the authentication page
    And the user is not logged in

  @story_signin @task_normal_signin
  Scenario: [Story] User wants to sign in with email and password
    As a user
    I want to sign in using my email and password
    So that I can access my account securely

    Given the user is on the sign-in page
    When the user selects the "Email & Password" sign-in method
    And the user enters a valid email address
    And the user enters a valid password
    And the user clicks the "Sign In" button
    Then the user should be successfully authenticated
    And redirected to the dashboard

  @story_signin @task_error_handling
  Scenario: [Story] User wants to see appropriate error for invalid credentials
    As a user
    I want to see clear error messages when I enter incorrect credentials
    So that I can understand what went wrong and fix it

    Given the user is on the sign-in page
    When the user selects the "Email & Password" sign-in method
    And the user enters an invalid email address or password
    And the user clicks the "Sign In" button
    Then the user should see an error message "Invalid email or password"
    And remain on the sign-in page

  @story_registration @task_normal_registration
  Scenario: [Story] User wants to register with email and password
    As a new user
    I want to create an account using my email and a password
    So that I can access the platform's services

    Given the user is on the registration page
    When the user selects the "Email & Password" registration method
    And the user enters a valid email address that is not already registered
    And the user enters a valid password that meets the password requirements
    And the user confirms the password
    And the user clicks the "Register" button
    Then a new account should be created
    And the user should be successfully authenticated
    And redirected to the onboarding flow

  @story_registration @task_error_handling
  Scenario: [Story] User wants to see appropriate error for duplicate email
    As a user
    I want to be notified if my email is already in use during registration
    So that I can sign in with existing credentials instead

    Given the user is on the registration page
    When the user selects the "Email & Password" registration method
    And the user enters an email address that is already registered
    And the user enters a valid password
    And the user confirms the password
    And the user clicks the "Register" button
    Then the user should see an error message "Email already in use"
    And remain on the registration page

  @story_account_recovery @task_password_reset
  Scenario: [Story] User wants to recover forgotten password
    As a user who has forgotten their password
    I want to reset my password through my email
    So that I can regain access to my account

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

  @story_security @task_account_lockout
  Scenario: [Story] User wants protection against brute force attacks
    As a security-conscious user
    I want my account to be protected from unauthorized access attempts
    So that my account remains secure even under attack

    Given the user is on the sign-in page
    When the user attempts to sign in with incorrect credentials 5 consecutive times
    Then the user's account should be temporarily locked
    And the user should see an error message indicating the account is locked
    And the user should be provided with account recovery options