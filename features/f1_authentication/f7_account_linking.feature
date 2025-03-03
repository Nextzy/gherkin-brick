Feature: Account Linking
  As a user
  I want to be able to link different authentication methods to my account
  So that I can sign in using any of my preferred methods

  Background:
    Given the user has an existing account

  Scenario: Account linking when signing in with a different method
    Given the user has an existing account created with email and password
    When the user attempts to sign in with a social provider (Google/Facebook/Line) using the same email
    Then the user should be prompted to link the accounts
    When the user confirms the account linking
    And provides their original account password for verification
    Then the accounts should be linked
    And the user should be successfully authenticated
    And redirected to the dashboard

  Scenario: Account linking from user profile settings
    Given the user is signed in to their account
    When the user navigates to account settings
    And selects "Link new authentication method"
    And chooses a social provider (Google/Facebook/Line)
    Then the user should be redirected to the provider's authentication page
    When the user successfully authenticates with the provider
    And grants the necessary permissions
    Then the new authentication method should be linked to the user's account
    And the user should see a success message "Account successfully linked"

  Scenario: Attempting to link an already used authentication method
    Given the user is signed in to their account
    When the user navigates to account settings
    And selects "Link new authentication method"
    And chooses a social provider (Google/Facebook/Line)
    Then the user should be redirected to the provider's authentication page
    When the user successfully authenticates with the provider
    And the provider account is already linked to another user
    Then the user should see an error message "This account is already linked to another user"
    And the authentication method should not be linked

  Scenario: Unlinking an authentication method
    Given the user is signed in to their account
    And the user has multiple authentication methods linked
    When the user navigates to account settings
    And selects to unlink a specific authentication method
    And confirms the unlinking operation
    Then the authentication method should be unlinked from the user's account
    And the user should see a success message "Authentication method unlinked"

  Scenario: Attempting to unlink the only authentication method
    Given the user is signed in to their account
    And the user has only one authentication method linked
    When the user navigates to account settings
    And selects to unlink the authentication method
    Then the user should see an error message "Cannot unlink the only authentication method"
    And the authentication method should remain linked