@epic_authentication
Feature: [Epic] Sign-in and Register with Facebook

  Background:
    Given the user is on the authentication page
    And the user is not logged in

  @story_signin @task_social_authentication
  Scenario: [Story] User wants to sign in with Facebook
    As a user with a Facebook account
    I want to sign in using my Facebook credentials
    So that I can access the platform without creating or remembering separate credentials

    Given the user is on the sign-in page
    When the user selects the "Sign in with Facebook" option
    Then the user should be redirected to the Facebook authentication page
    When the user successfully authenticates with their Facebook account
    And grants the necessary permissions
    Then the user should be redirected back to the application
    And the user should be successfully authenticated
    And redirected to the dashboard

  @story_signin @task_error_handling
  Scenario: [Story] User wants to cancel Facebook authentication
    As a user
    I want to be able to cancel the Facebook authentication process
    So that I can control when and if I connect my Facebook account

    Given the user is on the sign-in page
    When the user selects the "Sign in with Facebook" option
    Then the user should be redirected to the Facebook authentication page
    When the user cancels the Facebook authentication
    Then the user should be redirected back to the application
    And the user should see a message "Authentication cancelled"
    And remain on the sign-in page

  @story_registration @task_social_authentication
  Scenario: [Story] User wants to register with Facebook
    As a new user with a Facebook account
    I want to create an account using my Facebook profile
    So that I can access the platform without creating separate credentials

    Given the user is on the registration page
    When the user selects the "Sign up with Facebook" option
    Then the user should be redirected to the Facebook authentication page
    When the user successfully authenticates with their Facebook account
    And grants the necessary permissions
    And the Facebook account is not associated with an existing user
    Then a new account should be created using the Facebook profile information
    And the user should be successfully authenticated
    And redirected to the onboarding flow

  @story_signin @task_error_handling
  Scenario: [Story] User wants appropriate guidance when Facebook account is not registered
    As a user
    I want clear feedback when my Facebook account isn't linked to an existing account
    So that I can understand why sign-in failed and what actions I can take

    Given the user is on the sign-in page
    When the user selects the "Sign in with Facebook" option
    Then the user should be redirected to the Facebook authentication page
    When the user successfully authenticates with their Facebook account
    And grants the necessary permissions
    And the Facebook account is not associated with an existing user
    Then the user should see a message "No account found with this Facebook account"
    And be prompted to register

  @story_signin @task_error_handling
  Scenario: [Story] User wants appropriate error when declining permissions
    As a user
    I want clear feedback when I decline necessary permissions
    So that I understand why the authentication process couldn't be completed

    Given the user is on the sign-in page
    When the user selects the "Sign in with Facebook" option
    Then the user should be redirected to the Facebook authentication page
    When the user successfully authenticates with their Facebook account
    But declines to grant the necessary permissions
    Then the user should be redirected back to the application
    And the user should see an error message "Insufficient permissions"
    And remain on the sign-in page