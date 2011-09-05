Feature: User related features
  In order to use website features
  As a user
  I want to be able to see profile, edit profile, change password

  Scenario Outline: Show profile
    Given I have confirmed user "<First Name>" "<Last Name>" with username "<Username>", email "<Email>", password "<Password>", college "<College>" and affiliation "<Affiliation>"
    And user signed in as "<Email>" with "<Password>"
    When I follow "Edit Profile"
    Then I should see "Edit User"
    And the "Username" field should contain "<Username>"
    And the "First Name" field should contain "<First Name>"
    And the "Last Name" field should contain "<Last Name>"
    And the "user_affiliation" field should contain "<Affiliation>"
    And the "user_college_id" field should contain "<College>" college id
    And the "Email" field should contain "<Email>"

    Examples:
    | College        | Username     | First Name | Last Name | Affiliation | Email               | Password  |
    | Clemson        | test_user    | Test       | User      | Fan         | test@example.com    | 12345678  |
    | Boston College | test_client  | Test       | Client    | Alumni      | client@example.com  | 87654321  |
    | Alabama        | test_student | Test       | Student   | Student     | student@example.com | 123456789 |

  Scenario Outline: Edit profile
    Given I have confirmed user "<First Name>" "<Last Name>" with username "<Username>", email "<Email>", password "<Password>", college "<College>" and affiliation "<Affiliation>"
    And I have "<New College>" college in "SEC"
    And user signed in as "<Email>" with "<Password>"
    When I follow "Edit Profile"
    And I fill in "Username" with "<New Username>"
    And I fill in "First Name" with "<New First Name>"
    And I fill in "Last Name" with "<New Last Name>"
    And I select "<New Affiliation>" from "user_affiliation"
    And I select "<New College>" from "user_college_id"
    And I fill in "Email" with "<New Email>"
    And I fill in "Current password" with "<Password>"
    And I press "Update"
    Then I should see "You updated your account successfully"
    And I follow "Edit Profile"
    And the "Username" field should contain "<New Username>"
    And the "First Name" field should contain "<New First Name>"
    And the "Last Name" field should contain "<New Last Name>"
    And the "user_affiliation" field should contain "<New Affiliation>"
    And the "user_college_id" field should contain "<New College>" college id
    And the "Email" field should contain "<New Email>"
    
    Examples:
    | College        | New College    | Username     | New Username  | First Name | New First Name | Last Name | New Last Name | Affiliation | New Affiliation | Email               | New Email            | Password  |
    | Clemson        | Alabama        | test_user    | test_user2    | Test       | Test2          | User      | User2         | Fan         | Alumni          | test@example.com    | test2@example.com    | 12345678  |
    | Boston College | Clemson        | test_client  | test_client2  | Test       | Test2          | Client    | Client2       | Alumni      | Student         | client@example.com  | client2@example.com  | 87654321  |
    | Alabama        | Boston College | test_student | test_student2 | Test       | Test2          | Student   | Student2      | Student     | Fan             | student@example.com | student2@example.com | 123456789 |

  Scenario Outline: Change password
    Given I have confirmed user "<First Name>" "<Last Name>" with username "<Username>", email "<Email>", password "<Password>", college "<College>" and affiliation "<Affiliation>"
    And user signed in as "<Email>" with "<Password>"
    When I follow "Edit Profile"
    And I fill in "Current password" with "<Password>"
    And I fill in "Password" with "<New Password>"
    And I fill in "Password confirmation" with "<New Password>"
    And I press "Update"
    Then I should see "You updated your account successfully"
    And I follow "Sign out"
    And I follow "Sign In"
    And I fill in "Email" with "<Email>"
    And I fill in "Password" with "<New Password>"
    And I press "Sign in"
    And I should see "Signed in successfully"
    
    Examples:
    | College        | Username     | First Name | Last Name | Affiliation | Email               | Password  | New Password |
    | Clemson        | test_user    | Test       | User      | Fan         | test@example.com    | 12345678  | 12345678a    |
    | Boston College | test_client  | Test       | Client    | Alumni      | client@example.com  | 87654321  | 87654321b    |
    | Alabama        | test_student | Test       | Student   | Student     | student@example.com | 123456789 | 123456789c   |
