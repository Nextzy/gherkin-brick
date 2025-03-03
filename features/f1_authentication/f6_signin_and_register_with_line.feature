@epic_authentication
Feature: [Epic] Sign-in and Register with Line

  Background:
    Given the user is on the authentication page
    And the user is not logged in

  @story_signin @task_social_authentication
  Scenario: [Story] User wants to sign in with Line
    As a user with a Line account
    I want to sign in using my Line credentials
    So that I can access the platform without creating or remembering separate credentials

    Given the user is on the sign-in page
    When the user selects the "Sign in with Line" option
    Then the user should be redirected to the Line authentication page
    When the user successfully authenticates with their Line account
    And grants the necessary permissions
    Then the user should be redirected back to the application
    And the user should be successfully authenticated
    And redirected to the dashboard

  @story_signin @task_error_handling
  Scenario: [Story] User wants to cancel Line authentication
    As a user
    I want to be able to cancel the Line authentication process
    So that I can control when and if I connect my Line account

    Given the user is on the sign-in page
    When the user selects the "Sign in with Line" option
    Then the user should be redirected to the Line authentication page
    When the user cancels the Line authentication
    Then the user should be redirected back to the application
    And the user should see a message "Authentication cancelled"
    And remain on the sign-in page

  @story_registration @task_social_authentication
  Scenario: [Story] User wants to register with Line
    As a new user with a Line account
    I want to create an account using my Line profile
    So that I can access the platform without creating separate credentials

    Given the user is on the registration page
    When the user selects the "Sign up with Line" option
    Then the user should be redirected to the Line authentication page
    When the user successfully authenticates with their Line account
    And grants the necessary permissions
    And the Line account is not associated with an existing user
    Then a new account should be created using the Line profile information
    And the user should be successfully authenticated
    And redirected to the onboarding flow

  @story_signin @task_error_handling
  Scenario: [Story] User wants appropriate guidance when Line account is not registered
    As a user
    I want clear feedback when my Line account isn't linked to an existing account
    So that I can understand why sign-in failed and what actions I can take

    Given the user is on the sign-in page
    When the user selects the "Sign in with Line" option
    Then the user should be redirected to the Line authentication page
    When the user successfully authenticates with their Line account
    And grants the necessary permissions
    And the Line account is not associated with an existing user
    Then the user should see a message "No account found with this Line account"
    And be prompted to register

  @story_signin @task_error_handling
  Scenario: [Story] User wants appropriate error when declining permissions
    As a user
    I want clear feedback when I decline necessary permissions
    So that I understand why the authentication process couldn't be completed

    Given the user is on the sign-in page
    When the user selects the "Sign in with Line" option
    Then the user should be redirected to the Line authentication page
    When the user successfully authenticates with their Line account
    But declines to grant the necessary permissions
    Then the user should be redirected back to the application
    And the user should see an error message "Insufficient permissions"
    And remain on the sign-in page