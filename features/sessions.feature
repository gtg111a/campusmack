Feature: Session related features
  In order to use website features
  As a user
  I want to be able to sign up, sign in and sign out
  
  Scenario Outline: Sign Up
    Given I have "<College>" college in "SEC"
    And I am not authenticated
    And I am on signup page
    When I fill in "Username" with "<Username>"
    And I fill in "First Name" with "<First Name>"
    And I fill in "Last Name" with "<Last Name>"
    And I select "<Affiliation>" from "user_affiliation"
    And I select "<College>" from "user_college_id"
    And I fill in "Email" with "<Email>"
    And I fill in "Password" with "<Password>"
    And I fill in "Confirm password" with "<Password>"
    And I press "SIGN UP"
    Then I should see "You have signed up successfully. However, we could not sign you in because your account is unconfirmed"
    
    Examples:
    | College        | Username     | First Name | Last Name | Affiliation | Email               | Password  |
    | Clemson        | test_user    | Test       | User      | Fan         | test@example.com    | 12345678  |
    | Boston College | test_client  | Test       | Client    | Alumni      | client@example.com  | 87654321  |
    | Alabama        | test_student | Test       | Student   | Student     | student@example.com | 123456789 |

  Scenario Outline: Sign In
    Given I am not authenticated
    And I have confirmed Male user "<First Name>" "<Last Name>" with username "<Username>", email "<Email>", password "<Password>", college "<College>" and affiliation "<Affiliation>"
    When I am on root page
    And I follow "SIGN IN"
    And I fill in "Email" with "<Email>"
    And I fill in "Password" with "<Password>"
    And I press "SIGN IN"
    Then I should see "Signed in successfully"
    And I should not see "Sign Up"
    And I should not see "SIGN IN"
    
    Examples:
    | College        | Username     | First Name | Last Name | Affiliation | Email               | Password  |
    | Clemson        | test_user    | Test       | User      | Fan         | test@example.com    | 12345678  |
    | Boston College | test_client  | Test       | Client    | Alumni      | client@example.com  | 87654321  |
    | Alabama        | test_student | Test       | Student   | Student     | student@example.com | 123456789 |

  Scenario Outline: Sign Out
    Given I have confirmed Male user "<First Name>" "<Last Name>" with username "<Username>", email "<Email>", password "<Password>", college "<College>" and affiliation "<Affiliation>"
    And user signed in as "<Email>" with "<Password>"
    When I follow "SIGN OUT"
    Then I should see "Signed out successfully"
    And I should see "Sign Up"
    And I should see "SIGN IN"
    
    Examples:
    | College        | Username     | First Name | Last Name | Affiliation | Email               | Password  |
    | Clemson        | test_user    | Test       | User      | Fan         | test@example.com    | 12345678  |
    | Boston College | test_client  | Test       | Client    | Alumni      | client@example.com  | 87654321  |
    | Alabama        | test_student | Test       | Student   | Student     | student@example.com | 123456789 |
