@epic_authentication
Feature: [Epic] Sign-in and Register with Email Passwordless

  Background:
    Given the user is on the authentication page
    And the user is not logged in

  @story_signin @task_magic_link
  Scenario: [Story] User wants to sign in with passwordless email
    As a user
    I want to sign in without entering a password
    So that I can access my account more conveniently and securely

    Given the user is on the sign-in page
    When the user selects the "Email Passwordless" sign-in method
    And the user enters a valid registered email address
    And the user clicks the "Send Magic Link" button
    Then a magic link should be sent to the user's email address
    And the user should see a confirmation message "Magic link sent to your email"
    When the user clicks the magic link from their email
    Then the user should be successfully authenticated
    And redirected to the dashboard

  @story_signin @task_error_handling
  Scenario: [Story] User wants to see appropriate error for invalid email
    As a user
    I want to see clear error messages when I enter an invalid email
    So that I can correct my input

    Given the user is on the sign-in page
    When the user selects the "Email Passwordless" sign-in method
    And the user enters an invalid email address
    And the user clicks the "Send Magic Link" button
    Then the user should see an error message "Invalid email address"
    And remain on the sign-in page

  @story_registration @task_magic_link
  Scenario: [Story] User wants to register with passwordless email
    As a new user
    I want to create an account without setting up a password
    So that I can access the platform with minimal friction

    Given the user is on the registration page
    When the user selects the "Email Passwordless" registration method
    And the user enters a valid email address that is not already registered
    And the user clicks the "Send Magic Link" button
    Then a magic link should be sent to the user's email address
    And the user should see a confirmation message "Magic link sent to your email"
    When the user clicks the magic link from their email
    Then a new account should be created
    And the user should be successfully authenticated
    And redirected to the onboarding flow

  @story_registration @task_error_handling
  Scenario: [Story] User wants to see appropriate error for duplicate email
    As a user
    I want to be notified if my email is already registered
    So that I can sign in with existing account instead

    Given the user is on the registration page
    When the user selects the "Email Passwordless" registration method
    And the user enters an email address that is already registered
    And the user clicks the "Send Magic Link" button
    Then the user should see an error message "Email already in use"
    And remain on the registration page

  @story_security @task_link_expiration
  Scenario: [Story] User wants security for expired magic links
    As a security-conscious user
    I want magic links to expire after a certain time
    So that my account remains secure even if my email is compromised

    Given the user has requested a magic link
    And the magic link has expired
    When the user clicks on the expired magic link
    Then the user should see an error message "Link has expired"
    And the user should be prompted to request a new magic link