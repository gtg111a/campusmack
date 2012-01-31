Feature: Posts creation and edition
  In order to add my content
  As a user
  I want to be able to create posts, edit my posts, delete, vote
  
  @javascript
  Scenario Outline: Create Smack and Redemption
    Given I have confirmed Male user "<First Name>" "<Last Name>" with username "<Username>", email "<Email>", password "<Password>", college "<College>" and affiliation "<Affiliation>"
    And user signed in as "<Email>" with "<Password>"
    And I am on "<College>" college page
    And I follow "Add <Type>"
    And I should see "Submit a <College> <Type>"
    When I fill in "Title" with "<Title>"
    And I click found by selector "#switch_news"
    And I fill in "Article URL" with "google.com"
    And I fill in "Summary" with "<Text>"
    And I press "SUBMIT"
    Then I should see "<College> <Type> Submitted Successfully!"
    And I should see "<College> <Type>s"
    And I should see "<Title>"
    And I should see "<Text>"
    And I should see "Posted less than a minute ago by: <Username>"
    And I follow "My Posts"
    And I should see "<Title>"
    And I should see "<Text>"
    
    Examples:
    | College        | Username     | First Name | Last Name | Affiliation | Email               | Password  | Type       | Title           | Text                                                   |
    | Clemson        | test_user    | Test       | User      | Fan         | test@example.com    | 12345678  | Smack      | Test Smack      | Since I recommend you verify outcomes                  |
    | Clemson        | test_user    | Test       | User      | Fan         | test@example.com    | 12345678  | Redemption | Test Redemption | Rescue all errors and render error pages               |
    | Boston College | test_client  | Test       | Client    | Alumni      | client@example.com  | 87654321  | Smack      | Cool Post       | Some guidance for authentication is provided below     |
    | Boston College | test_client  | Test       | Client    | Alumni      | client@example.com  | 87654321  | Redemption | Cool Redemption | which can lead to hard-to-debug failures in subsequent |
    | Alabama        | test_student | Test       | Student   | Student     | student@example.com | 123456789 | Smack      | Top 10          | It is recommended that a new user is created           |
    | Alabama        | test_student | Test       | Student   | Student     | student@example.com | 123456789 | Redemption | Top 10 Reds     | I recommend you delete generated controller and view   |
  
  Scenario Outline: Edit Smack and Redemption
    Given I have confirmed Male user "<First Name>" "<Last Name>" with username "<Username>", email "<Email>", password "<Password>", college "<College>" and affiliation "<Affiliation>"
    And user signed in as "<Email>" with "<Password>"
    And I have "<College>" college <Type> "<Title>" with text "<Text>" created by "<Username>"
    And I am on <Type> "<Title>" page
    When I follow "Edit"
    And I fill in "Title" with "<New Title>"
    And I fill in "Summary" with "<New Text>"
    And I press "SUBMIT"
    Then I should see "Post updated"
    And I should see "<New Title>"
    And I should see "<New Text>"
    
    Examples:
    | College        | Username     | First Name | Last Name | Affiliation | Email               | Password  | Type       | Title           | Text                                                   |
    | Clemson        | test_user    | Test       | User      | Fan         | test@example.com    | 12345678  | Smack      | Test Smack      | Since I recommend you verify outcomes                  |
    | Clemson        | test_user    | Test       | User      | Fan         | test@example.com    | 12345678  | Redemption | Test Redemption | Rescue all errors and render error pages               |
    | Boston College | test_client  | Test       | Client    | Alumni      | client@example.com  | 87654321  | Smack      | Cool Post       | Some guidance for authentication is provided below     |
    | Boston College | test_client  | Test       | Client    | Alumni      | client@example.com  | 87654321  | Redemption | Cool Redemption | which can lead to hard-to-debug failures in subsequent |
    | Alabama        | test_student | Test       | Student   | Student     | student@example.com | 123456789 | Smack      | Top 10          | It is recommended that a new user is created           |
    | Alabama        | test_student | Test       | Student   | Student     | student@example.com | 123456789 | Redemption | Top 10 Reds     | I recommend you delete generated controller and view   |

  @javascript
  Scenario Outline: Delete Smack and Redemption
    Given I have confirmed Male user "<First Name>" "<Last Name>" with username "<Username>", email "<Email>", password "<Password>", college "<College>" and affiliation "<Affiliation>"
    And user signed in as "<Email>" with "<Password>"
    And I have "<College>" college <Type> "<Title>" with text "<Text>" created by "<Username>"
    And I am on <Type> "<Title>" page
    When I will confirm any dialog
    And I follow "Delete"
    Then I should see "Post Deleted Successfully"
    And I should not see "<Title>"
    And I should not see "<Text>"
    
    Examples:
    | College        | Username     | First Name | Last Name | Affiliation | Email               | Password  | Type       | Title           | Text                                                   |
    | Clemson        | test_user    | Test       | User      | Fan         | test@example.com    | 12345678  | Smack      | Test Smack      | Since I recommend you verify outcomes                  |
    | Clemson        | test_user    | Test       | User      | Fan         | test@example.com    | 12345678  | Redemption | Test Redemption | Rescue all errors and render error pages               |
    | Boston College | test_client  | Test       | Client    | Alumni      | client@example.com  | 87654321  | Smack      | Cool Post       | Some guidance for authentication is provided below     |
    | Boston College | test_client  | Test       | Client    | Alumni      | client@example.com  | 87654321  | Redemption | Cool Redemption | which can lead to hard-to-debug failures in subsequent |
    | Alabama        | test_student | Test       | Student   | Student     | student@example.com | 123456789 | Smack      | Top 10          | It is recommended that a new user is created           |
    | Alabama        | test_student | Test       | Student   | Student     | student@example.com | 123456789 | Redemption | Top 10 Reds     | I recommend you delete generated controller and view   |

  @f
  @javascript
  Scenario Outline: Vote Up/Down Smack and Redemption
    Given I have confirmed users
    | College        | Affiliation | Username     | First Name | Last Name | Affiliation | Email               | Password  |
    | Clemson        | Fan         | test_user    | Test       | User      | Fan         | test@example.com    | 12345678  |
    | Boston College | Alumni      | test_client  | Test       | Client    | Alumni      | client@example.com  | 87654321  |
    | Alabama        | Student     | test_student | Test       | Student   | Student     | student@example.com | 123456789 |
    And I have "Clemson" college <Type> "<Title>" with text "<Text>" created by "<Username>"
    And user signed in as "<Email>" with "<Password>"
    And I am on <Type> "<Title>" page
    And <Type> "<Title>" vote <UpDown> count is 0
    When I press <Button> button
    And I wait 2 seconds
    Then <Type> "<Title>" vote <UpDown> count should be 1
    And I reload the page
    And <Type> "<Title>" vote <UpDown> count should be 1
    
    Examples:
    | Button    | UpDown | Username     | Email               | Password  | Type       | Title           | Text                                                   |
    | Vote Up   | up     | test_user    | test@example.com    | 12345678  | Smack      | Test Smack      | Since I recommend you verify outcomes                  |
    | Vote Up   | up     | test_user    | test@example.com    | 12345678  | Redemption | Test Redemption | Rescue all errors and render error pages               |
    | Vote Up   | up     | test_user    | client@example.com  | 87654321  | Smack      | Cool Post       | Some guidance for authentication is provided below     |
    | Vote Up   | up     | test_user    | client@example.com  | 87654321  | Redemption | Cool Redemption | which can lead to hard-to-debug failures in subsequent |
    | Vote Up   | up     | test_student | student@example.com | 123456789 | Smack      | Top 10          | It is recommended that a new user is created           |
    | Vote Up   | up     | test_student | student@example.com | 123456789 | Redemption | Top 10 Reds     | I recommend you delete generated controller and view   |
    | Vote Down | down   | test_user    | test@example.com    | 12345678  | Smack      | Test Smack      | Since I recommend you verify outcomes                  |
    | Vote Down | down   | test_user    | test@example.com    | 12345678  | Redemption | Test Redemption | Rescue all errors and render error pages               |
    | Vote Down | down   | test_user    | client@example.com  | 87654321  | Smack      | Cool Post       | Some guidance for authentication is provided below     |
    | Vote Down | down   | test_user    | client@example.com  | 87654321  | Redemption | Cool Redemption | which can lead to hard-to-debug failures in subsequent |
    | Vote Down | down   | test_student | student@example.com | 123456789 | Smack      | Top 10          | It is recommended that a new user is created           |
    | Vote Down | down   | test_student | student@example.com | 123456789 | Redemption | Top 10 Reds     | I recommend you delete generated controller and view   |

  Scenario Outline: Posts edit access
    Given I have confirmed users
    | College        | Affiliation | Username     | First Name | Last Name | Affiliation | Email               | Password  |
    | Clemson        | Fan         | test_user    | Test       | User      | Fan         | test@example.com    | 12345678  |
    | Boston College | Alumni      | test_client  | Test       | Client    | Alumni      | client@example.com  | 87654321  |
    | Alabama        | Student     | test_student | Test       | Student   | Student     | student@example.com | 123456789 |
    And I have "Clemson" college <Type> "<Title>" with text "<Text>" created by "<Username>"
    And user signed in as "<Email>" with "<Password>"
    When I am on <Type> "<Title>" page
    Then I should <Action> element "ul.actions a img[alt='Edit']"
    And I go to <Type> "<Title>" edit page
    And I should see "<Edit Page Content>"
    
    Examples:
    | Type       | Title           | Text                                     | Username  | Email               | Password  | Action   | Edit Page Content                          |
    | Smack      | Test Smack      | Since I recommend you verify outcomes    | test_user | test@example.com    | 12345678  | have     | Edit post                                  |
    | Smack      | Test Smack      | Since I recommend you verify outcomes    | test_user | client@example.com  | 87654321  | not have | You must be signed-up/signed-in to use this function |
    | Smack      | Test Smack      | Since I recommend you verify outcomes    | test_user | student@example.com | 123456789 | not have | You must be signed-up/signed-in to use this function |
    | Smack      | Test Smack      | Since I recommend you verify outcomes    | test_user |                     |           | not have | You must be signed-up/signed-in to use this function |
    | Redemption | Test Redemption | Rescue all errors and render error pages | test_user | test@example.com    | 12345678  | have     | Edit post                                  |
    | Redemption | Test Redemption | Rescue all errors and render error pages | test_user | client@example.com  | 87654321  | not have | You must be signed-up/signed-in to use this function |
    | Redemption | Test Redemption | Rescue all errors and render error pages | test_user | student@example.com | 123456789 | not have | You must be signed-up/signed-in to use this function |
    | Redemption | Test Redemption | Rescue all errors and render error pages | test_user |                     |           | not have | You must be signed-up/signed-in to use this function |

  Scenario Outline: Posts delete access
    Given I have confirmed users
    | College        | Affiliation | Username     | First Name | Last Name | Affiliation | Email               | Password  |
    | Clemson        | Fan         | test_user    | Test       | User      | Fan         | test@example.com    | 12345678  |
    | Boston College | Alumni      | test_client  | Test       | Client    | Alumni      | client@example.com  | 87654321  |
    | Alabama        | Student     | test_student | Test       | Student   | Student     | student@example.com | 123456789 |
    And I have "Clemson" college <Type> "<Title>" with text "<Text>" created by "<Username>"
    And user signed in as "<Email>" with "<Password>"
    When I am on <Type> "<Title>" page
    Then I should <Action> element "ul.actions a img[alt='Delete']"

    Examples:
    | Type       | Title           | Text                                     | Username  | Email               | Password  | Action   |
    | Smack      | Test Smack      | Since I recommend you verify outcomes    | test_user | test@example.com    | 12345678  | have     |
    | Smack      | Test Smack      | Since I recommend you verify outcomes    | test_user | client@example.com  | 87654321  | not have |
    | Smack      | Test Smack      | Since I recommend you verify outcomes    | test_user | student@example.com | 123456789 | not have |
    | Smack      | Test Smack      | Since I recommend you verify outcomes    | test_user |                     |           | not have |
    | Redemption | Test Redemption | Rescue all errors and render error pages | test_user | test@example.com    | 12345678  | have     |
    | Redemption | Test Redemption | Rescue all errors and render error pages | test_user | client@example.com  | 87654321  | not have |
    | Redemption | Test Redemption | Rescue all errors and render error pages | test_user | student@example.com | 123456789 | not have |
    | Redemption | Test Redemption | Rescue all errors and render error pages | test_user |                     |           | not have |

  @javascript
  Scenario Outline: Post Reporting
    Given I have confirmed users
    | College        | Affiliation | Username     | First Name | Last Name | Affiliation | Email               | Password  |
    | Clemson        | Fan         | test_user    | Test       | User      | Fan         | test@example.com    | 12345678  |
    | Boston College | Alumni      | test_client  | Test       | Client    | Alumni      | client@example.com  | 87654321  |
    | Alabama        | Student     | test_student | Test       | Student   | Student     | student@example.com | 123456789 |
    And I have reasons
    | Spam                  |
    | Inappropriate content |
    | Offensive content     |
    And I have "Clemson" college <Type> "<Title>" with text "<Text>" created by "<Username>"
    And user signed in as "<Email>" with "<Password>"
    And I am on <Type> "<Title>" page
    When I follow "Report Post"
    And I wait 2 seconds
    And I select "<Reason>" from "report_reason_id"
    And I fill in "Other" with "<Custom Reason>"
    And I press "Report"
    Then I should see "Thanks!"
    And I reload the page
    And I should not see "Report Abuse"
    And I should have report for "<Title>" from "<Email>" with reason "<Reason>" and custom reason "<Custom Reason>"
    
    Examples:
    | Type       | Title           | Text                                     | Username  | Email               | Password  | Reason                | Custom Reason  |
    | Smack      | Test Smack      | Since I recommend you verify outcomes    | test_user | client@example.com  | 87654321  | Spam                  |                |
    | Redemption | Test Redemption | Rescue all errors and render error pages | test_user | student@example.com | 123456789 | Inappropriate content |                |
    | Smack      | Test Smack      | Since I recommend you verify outcomes    | test_user | client@example.com  | 87654321  |                       | spammer        |
    | Redemption | Test Redemption | Rescue all errors and render error pages | test_user | student@example.com | 123456789 |                       | this is a scam |
    



