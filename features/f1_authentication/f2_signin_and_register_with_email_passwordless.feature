Feature: Sign-in and Register with Email Passwordless
  As a user
  I want to be able to authenticate myself using email without a password
  So that I can access the platform securely without remembering credentials

  Background:
    Given the user is on the authentication page
    And the user is not logged in

  Scenario: Sign-in with email passwordless
    Given the user is on the sign-in page
    When the user selects the "Email Passwordless" sign-in method
    And the user enters a valid registered email address
    And the user clicks the "Send Magic Link" button
    Then a magic link should be sent to the user's email address
    And the user should see a confirmation message "Magic link sent to your email"
    When the user clicks the magic link from their email
    Then the user should be successfully authenticated
    And redirected to the dashboard

  Scenario: Sign-in with email passwordless - invalid email
    Given the user is on the sign-in page
    When the user selects the "Email Passwordless" sign-in method
    And the user enters an invalid email address
    And the user clicks the "Send Magic Link" button
    Then the user should see an error message "Invalid email address"
    And remain on the sign-in page

  Scenario: Register with email passwordless
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

  Scenario: Register with email passwordless - email already in use
    Given the user is on the registration page
    When the user selects the "Email Passwordless" registration method
    And the user enters an email address that is already registered
    And the user clicks the "Send Magic Link" button
    Then the user should see an error message "Email already in use"
    And remain on the registration page

  Scenario: Magic link expiration
    Given the user has requested a magic link
    And the magic link has expired
    When the user clicks on the expired magic link
    Then the user should see an error message "Link has expired"
    And the user should be prompted to request a new magic link