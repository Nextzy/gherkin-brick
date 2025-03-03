@epic_authentication @epic_account_management
Feature: [Epic] Account Linking

  Background:
    Given the user has an existing account

  @story_account_linking @task_automatic_linking
  Scenario: [Story] User wants to link accounts when signing in with different method
    As a user with multiple online identities
    I want to link my social accounts to my existing account
    So that I can sign in using any of my preferred authentication methods

    Given the user has an existing account created with email and password
    When the user attempts to sign in with a social provider (Google/Facebook/Line) using the same email
    Then the user should be prompted to link the accounts
    When the user confirms the account linking
    And provides their original account password for verification
    Then the accounts should be linked
    And the user should be successfully authenticated
    And redirected to the dashboard

  @story_account_linking @task_manual_linking
  Scenario: [Story] User wants to link additional authentication methods
    As a user
    I want to add new authentication methods to my existing account
    So that I can sign in using alternative credentials when needed

    Given the user is signed in to their account
    When the user navigates to account settings
    And selects "Link new authentication method"
    And chooses a social provider (Google/Facebook/Line)
    Then the user should be redirected to the provider's authentication page
    When the user successfully authenticates with the provider
    And grants the necessary permissions
    Then the new authentication method should be linked to the user's account
    And the user should see a success message "Account successfully linked"

  @story_account_linking @task_error_handling
  Scenario: [Story] User wants appropriate error for already linked methods
    As a user
    I want clear feedback when trying to link an already used authentication method
    So that I understand why the linking process failed

    Given the user is signed in to their account
    When the user navigates to account settings
    And selects "Link new authentication method"
    And chooses a social provider (Google/Facebook/Line)
    Then the user should be redirected to the provider's authentication page
    When the user successfully authenticates with the provider
    And the provider account is already linked to another user
    Then the user should see an error message "This account is already linked to another user"
    And the authentication method should not be linked

  @story_account_management @task_method_removal
  Scenario: [Story] User wants to remove authentication methods
    As a user
    I want to unlink authentication methods from my account
    So that I can manage how I access my account

    Given the user is signed in to their account
    And the user has multiple authentication methods linked
    When the user navigates to account settings
    And selects to unlink a specific authentication method
    And confirms the unlinking operation
    Then the authentication method should be unlinked from the user's account
    And the user should see a success message "Authentication method unlinked"

  @story_account_management @task_error_handling
  Scenario: [Story] User wants safeguard against removing all authentication methods
    As a user
    I want to be prevented from removing my only authentication method
    So that I don't lock myself out of my account accidentally

    Given the user is signed in to their account
    And the user has only one authentication method linked
    When the user navigates to account settings
    And selects to unlink the authentication method
    Then the user should see an error message "Cannot unlink the only authentication method"
    And the authentication method should remain linked