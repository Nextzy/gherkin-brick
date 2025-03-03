Feature: Authentication
  As a user
  I want to be able to authenticate myself using various methods
  So that I can access the platform securely in a way that is convenient for me

  Background:
    Given the user is on the authentication page
    And the user is not logged in

  Scenario: Sign-in with email and password
    Given the user is on the sign-in page
    When the user selects the "Email & Password" sign-in method
    And the user enters a valid email address
    And the user enters a valid password
    And the user clicks the "Sign In" button
    Then the user should be successfully authenticated
    And redirected to the dashboard

  Scenario: Sign-in with invalid email and password
    Given the user is on the sign-in page
    When the user selects the "Email & Password" sign-in method
    And the user enters an invalid email address or password
    And the user clicks the "Sign In" button
    Then the user should see an error message "Invalid email or password"
    And remain on the sign-in page

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

  Scenario: Register with email that is already in use
    Given the user is on the registration page
    When the user selects the "Email & Password" registration method
    And the user enters an email address that is already registered
    And the user enters a valid password
    And the user confirms the password
    And the user clicks the "Register" button
    Then the user should see an error message "Email already in use"
    And remain on the registration page

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

  Scenario: Sign-in with invalid OTP
    Given the user is on the sign-in page
    When the user selects the "Mobile + OTP" sign-in method
    And the user enters a valid registered mobile number
    And the user clicks the "Send OTP" button
    And the user enters an incorrect OTP
    And the user clicks the "Verify" button
    Then the user should see an error message "Invalid OTP"
    And remain on the sign-in page with the option to resend OTP

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

  Scenario: Sign-in with Google
    Given the user is on the sign-in page
    When the user selects the "Sign in with Google" option
    Then the user should be redirected to the Google authentication page
    When the user successfully authenticates with their Google account
    And grants the necessary permissions
    Then the user should be redirected back to the application
    And the user should be successfully authenticated
    And redirected to the dashboard

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

  Scenario: Sign-in with Facebook
    Given the user is on the sign-in page
    When the user selects the "Sign in with Facebook" option
    Then the user should be redirected to the Facebook authentication page
    When the user successfully authenticates with their Facebook account
    And grants the necessary permissions
    Then the user should be redirected back to the application
    And the user should be successfully authenticated
    And redirected to the dashboard

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

  Scenario: Sign-in with Line
    Given the user is on the sign-in page
    When the user selects the "Sign in with Line" option
    Then the user should be redirected to the Line authentication page
    When the user successfully authenticates with their Line account
    And grants the necessary permissions
    Then the user should be redirected back to the application
    And the user should be successfully authenticated
    And redirected to the dashboard

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

  Scenario: Account linking when signing in with a different method
    Given the user has an existing account created with email and password
    When the user attempts to sign in with a social provider (Google/Facebook/Line) using the same email
    Then the user should be prompted to link the accounts
    When the user confirms the account linking
    And provides their original account password for verification
    Then the accounts should be linked
    And the user should be successfully authenticated
    And redirected to the dashboard

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

  Scenario: Account lockout after multiple failed attempts
    Given the user is on the sign-in page
    When the user attempts to sign in with incorrect credentials 5 consecutive times
    Then the user's account should be temporarily locked
    And the user should see an error message indicating the account is locked
    And the user should be provided with account recovery options