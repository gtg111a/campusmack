Feature: User related features
  In order to use website features
  As a user
  I want to be able to see profile, edit profile, change password

  Scenario Outline: Show profile
    Given I have confirmed <Gender> user "<First Name>" "<Last Name>" with username "<Username>", email "<Email>", password "<Password>", college "<College>" and affiliation "<Affiliation>"
    And user signed in as "<Email>" with "<Password>"
    When I follow "Profile"
    Then I should see "EDIT USER INFO"
    And the "Username" field should contain "<Username>"
    And the "First Name" field should contain "<First Name>"
    And the "Last Name" field should contain "<Last Name>"
    And the "user_affiliation" field should contain "<Affiliation>"
    And the "user_college_id" field should contain "<College>" college id
    And the "Email" field should contain "<Email>"

    Examples:
    | College        | Username     | First Name | Last Name | Gender | Affiliation | Email               | Password  |
    | Clemson        | test_user    | Test       | User      | Male   | Fan         | test@example.com    | 12345678  |
    | Boston College | test_client  | Test       | Client    | Female | Alumni      | client@example.com  | 87654321  |
    | Alabama        | test_student | Test       | Student   | Male   | Student     | student@example.com | 123456789 |

  Scenario Outline: Edit profile
    Given I have confirmed <Gender> user "<First Name>" "<Last Name>" with username "<Username>", email "<Email>", password "<Password>", college "<College>" and affiliation "<Affiliation>"
    And I have "<New College>" college in "SEC"
    And user signed in as "<Email>" with "<Password>"
    When I follow "Profile"
    And I fill in "Username" with "<New Username>"
    And I fill in "First Name" with "<New First Name>"
    And I fill in "Last Name" with "<New Last Name>"
    And I select "<New Gender>" from "user_gender"
    And I select "<New Affiliation>" from "user_affiliation"
    And I select "<New College>" from "user_college_id"
    And I fill in "Email" with "<New Email>"
    And I fill in "Old password" with "<Password>"
    And I press "UPDATE"
    Then I should see "Account updated successfully"
    And I follow "Profile"
    And the "Username" field should contain "<New Username>"
    And the "First Name" field should contain "<New First Name>"
    And the "Last Name" field should contain "<New Last Name>"
    And the "user_gender" select should be set to "<New Gender>"
    And the "user_affiliation" field should contain "<New Affiliation>"
    And the "user_college_id" field should contain "<New College>" college id
    And the "Email" field should contain "<New Email>"
    
    Examples:
    | College        | New College    | Username     | New Username  | First Name | New First Name | Last Name | New Last Name | Gender | New Gender | Affiliation | New Affiliation | Email               | New Email            | Password  |
    | Clemson        | Alabama        | test_user    | test_user2    | Test       | Test2          | User      | User2         | Male   | Female     | Fan         | Alumni          | test@example.com    | test2@example.com    | 12345678  |
    | Boston College | Clemson        | test_client  | test_client2  | Test       | Test2          | Client    | Client2       | Female | Male       | Alumni      | Student         | client@example.com  | client2@example.com  | 87654321  |
    | Alabama        | Boston College | test_student | test_student2 | Test       | Test2          | Student   | Student2      | Male   | Female     | Student     | Fan             | student@example.com | student2@example.com | 123456789 |

  Scenario Outline: Change password
    Given I have confirmed <Gender> user "<First Name>" "<Last Name>" with username "<Username>", email "<Email>", password "<Password>", college "<College>" and affiliation "<Affiliation>"
    And user signed in as "<Email>" with "<Password>"
    When I follow "Profile"
    And I fill in "Old password" with "<Password>"
    And I fill in "New Password" with "<New Password>"
    And I fill in "Confirm password" with "<New Password>"
    And I press "UPDATE"
    Then I should see "Account updated successfully"
    And I follow "SIGN OUT"
    And I follow "SIGN IN"
    And I fill in "Email" with "<Email>"
    And I fill in "Password" with "<New Password>"
    And I press "SIGN IN"
    And I should see "Signed in successfully"
    
    Examples:
    | College        | Username     | First Name | Last Name | Gender | Affiliation | Email               | Password  | New Password |
    | Clemson        | test_user    | Test       | User      | Female | Fan         | test@example.com    | 12345678  | 12345678a    |
    | Boston College | test_client  | Test       | Client    | Male   | Alumni      | client@example.com  | 87654321  | 87654321b    |
    | Alabama        | test_student | Test       | Student   | Female | Student     | student@example.com | 123456789 | 123456789c   |
