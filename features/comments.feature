Feature: Comments creating, editing and deleting
  In order to comment
  As a registered user
  I want to be able to create comments, edit and delete my comments
  
  @javascript
  Scenario Outline: Creating Comments
    Given I have confirmed users
    | College        | Affiliation | Username     | First Name | Last Name | Affiliation | Email               | Password  |
    | Auburn         | Fan         | test_user    | Test       | User      | Fan         | test@example.com    | 12345678  |
    | Miami          | Alumni      | test_client  | Test       | Client    | Alumni      | client@example.com  | 87654321  |
    | North Carolina | Student     | test_student | Test       | Student   | Student     | student@example.com | 123456789 |
    And I have "<Name>" <ConfOrColl> <Type> "<Title>" with text "bla-bla-bla" created by "<Username>"
    And user signed in as "<Email>" with "<Password>"
    And I am on <Type> "<Title>" page
    And I fill in "Comment" with "<Comment>"
    When I press "Submit Comment"
    Then I should see "<Comment>"
    And I should see "Posted less than a minute ago by <Signed In>" within "div.comment"
    And I should see "Edit" within "div.comment"
    And I should see "Delete" within "div.comment"
    And I reload the page
    And I should see "<Comment>"
    And I should see "Posted less than a minute ago by <Signed In>" within "div.comment"
    And I should see "Edit" within "div.comment"
    And I should see "Delete" within "div.comment"
    
    Examples:
    | ConfOrColl | Name | Type       | Title           | Username    | Email            | Password | Signed In | Comment            |
    | conference | SEC  | Smack      | Test Smack      | test_user   | test@example.com | 12345678 | test_user | Test comment no 01 |
    | conference | SEC  | Redemption | Test Redemption | test_user   | test@example.com | 12345678 | test_user | Test comment no 02 |
    | conference | SEC  | Smack      | Test Smack      | test_client | test@example.com | 12345678 | test_user | Test comment no 03 |
    | conference | SEC  | Redemption | Test Redemption | test_client | test@example.com | 12345678 | test_user | Test comment no 04 |
    | college | Auburn  | Smack      | Test Smack      | test_user   | test@example.com | 12345678 | test_user | Test comment no 05 |
    | college | Auburn  | Redemption | Test Redemption | test_user   | test@example.com | 12345678 | test_user | Test comment no 06 |
    | college | Auburn  | Smack      | Test Smack      | test_client | test@example.com | 12345678 | test_user | Test comment no 07 |
    | college | Auburn  | Redemption | Test Redemption | test_client | test@example.com | 12345678 | test_user | Test comment no 08 |
  
  Scenario Outline: Editing Comments
    Given I have conferences
    | Conference |
    | SEC        |
    | ACC        |
    Given I have confirmed users
    | College        | Affiliation | Username     | First Name | Last Name | Affiliation | Email               | Password  |
    | Auburn         | Fan         | test_user    | Test       | User      | Fan         | test@example.com    | 12345678  |
    | Miami          | Alumni      | test_client  | Test       | Client    | Alumni      | client@example.com  | 87654321  |
    | North Carolina | Student     | test_student | Test       | Student   | Student     | student@example.com | 123456789 |
    And I have "<Name>" <ConfOrColl> <Type> "<Title>" with text "bla-bla-bla" created by "<Username>"
    And I have comment for "<Title>" with text "<Old Text>" created by "<Username>"
    And user signed in as "<Email>" with "<Password>"
    And I am on <Type> "<Title>" page
    When I follow "Edit" within "div.comment"
    Then I should see "Edit comment"
    And I fill in "Comment" with "<New Text>"
    And I press "Update Comment"
    And I should see "Comment updated."
    And I should see "<New Text>"
    
    Examples:
    | ConfOrColl | Name   | Type       | Title           | Username  | Email            | Password | Old Text           | New Text          |
    | conference | SEC    | Smack      | Test Smack      | test_user | test@example.com | 12345678 | Test comment no 01 | New comment no 01 |
    | conference | SEC    | Redemption | Test Redemption | test_user | test@example.com | 12345678 | Test comment no 02 | New comment no 02 |
    | college    | Auburn | Smack      | Test Smack      | test_user | test@example.com | 12345678 | Test comment no 03 | New comment no 03 |
    | college    | Auburn | Redemption | Test Redemption | test_user | test@example.com | 12345678 | Test comment no 04 | New comment no 04 |

  @javascript
  Scenario Outline: Deleting Comments
    Given I have conferences
    | Conference |
    | SEC        |
    | ACC        |
    Given I have confirmed users
    | College        | Affiliation | Username     | First Name | Last Name | Affiliation | Email               | Password  |
    | Auburn         | Fan         | test_user    | Test       | User      | Fan         | test@example.com    | 12345678  |
    | Miami          | Alumni      | test_client  | Test       | Client    | Alumni      | client@example.com  | 87654321  |
    | North Carolina | Student     | test_student | Test       | Student   | Student     | student@example.com | 123456789 |
    And I have "<Name>" <ConfOrColl> <Type> "<Title>" with text "bla-bla-bla" created by "<Username>"
    And I have comment for "<Title>" with text "<Old Text>" created by "<Username>"
    And user signed in as "<Email>" with "<Password>"
    And I am on <Type> "<Title>" page
    And I will confirm any dialog
    When I follow "Delete" within "div.comment"
    Then I should not see "<Old Text>"
    And I reload the page
    And I should not see "<Old Text>"
    
    Examples:
    | ConfOrColl | Name   | Type       | Title           | Username  | Email            | Password | Old Text           | New Text          |
    | conference | SEC    | Smack      | Test Smack      | test_user | test@example.com | 12345678 | Test comment no 01 | New comment no 01 |
    | conference | SEC    | Redemption | Test Redemption | test_user | test@example.com | 12345678 | Test comment no 02 | New comment no 02 |
    | college    | Auburn | Smack      | Test Smack      | test_user | test@example.com | 12345678 | Test comment no 03 | New comment no 03 |
    | college    | Auburn | Redemption | Test Redemption | test_user | test@example.com | 12345678 | Test comment no 04 | New comment no 04 |
  
  Scenario Outline: Unable to edit and delete others comments
    Given I have conferences
    | Conference |
    | SEC        |
    | ACC        |
    Given I have confirmed users
    | College        | Affiliation | Username     | First Name | Last Name | Affiliation | Email               | Password  |
    | Auburn         | Fan         | test_user    | Test       | User      | Fan         | test@example.com    | 12345678  |
    | Miami          | Alumni      | test_client  | Test       | Client    | Alumni      | client@example.com  | 87654321  |
    | North Carolina | Student     | test_student | Test       | Student   | Student     | student@example.com | 123456789 |
    And I have "<Name>" <ConfOrColl> <Type> "<Title>" with text "bla-bla-bla" created by "<Username>"
    And I have comment for "<Title>" with text "<Old Text>" created by "<Username>"
    And user signed in as "<Email>" with "<Password>"
    When I am on <Type> "<Title>" page
    Then I should not see "Edit" within "div.comment"
    And I should not see "Delete" within "div.comment"
    And I go to "<Old Text>" comment edit page
    And I should see "You are not authorized to access this page."
    
    Examples:
    | ConfOrColl | Name   | Type       | Title           | Username  | Email              | Password | Old Text           | New Text          |
    | conference | SEC    | Smack      | Test Smack      | test_user | client@example.com | 87654321 | Test comment no 01 | New comment no 01 |
    | conference | SEC    | Redemption | Test Redemption | test_user | client@example.com | 87654321 | Test comment no 02 | New comment no 02 |
    | college    | Auburn | Smack      | Test Smack      | test_user | client@example.com | 87654321 | Test comment no 03 | New comment no 03 |
    | college    | Auburn | Redemption | Test Redemption | test_user | client@example.com | 87654321 | Test comment no 04 | New comment no 04 |

