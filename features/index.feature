Feature: Posts listing
  In order to view content
  As a user
  I want to be able to view posts in their place
  
  Scenario Outline: Listing College Posts
    Given I have colleges
    | Conference | College        |
    | SEC        | Auburn         |
    | SEC        | Kentucky       |
    | ACC        | Miami          |
    | ACC        | North Carolina |
    And I have confirmed users
    | College        | Affiliation | Username     | First Name | Last Name | Affiliation | Email               | Password  |
    | Auburn         | Fan         | test_user    | Test       | User      | Fan         | test@example.com    | 12345678  |
    | Miami          | Alumni      | test_client  | Test       | Client    | Alumni      | client@example.com  | 87654321  |
    | North Carolina | Student     | test_student | Test       | Student   | Student     | student@example.com | 123456789 |
    And I have posts
    | Type       | Kind  | College | Title   | Username  |
    | Smack      | Video | Auburn  | Title01 | test_user |
    | Smack      | Photo | Auburn  | Title02 | test_user |
    | Smack      | News  | Auburn  | Title03 | test_user |
    | Smack      | Stats | Auburn  | Title04 | test_user |
    | Redemption | Video | Auburn  | Title11 | test_user |
    | Redemption | Photo | Auburn  | Title12 | test_user |
    | Redemption | News  | Auburn  | Title13 | test_user |
    | Redemption | Stats | Auburn  | Title14 | test_user |
    | Smack      | Video | Miami   | Title21 | test_user |
    | Smack      | Photo | Miami   | Title22 | test_user |
    | Smack      | News  | Miami   | Title23 | test_user |
    | Smack      | Stats | Miami   | Title24 | test_user |
    | Redemption | Video | Miami   | Title31 | test_user |
    | Redemption | Photo | Miami   | Title32 | test_user |
    | Redemption | News  | Miami   | Title33 | test_user |
    | Redemption | Stats | Miami   | Title34 | test_user |
    When I am on <Page> page
    Then I should see "<See1>"
    And I should see "<See2>"
    And I should see "<See3>"
    And I should not see "<NotSee1>"
    And I should not see "<NotSee2>"
    And I should not see "<NotSee3>"

    Examples:
    | Page                         | See1    | See2    | See3    | NotSee1 | NotSee2 | NotSee3 |
    | "Auburn" college             | Title01 | Title12 | Title13 | Title21 | Title23 | Title32 |
    | "Auburn" college videos      | Title01 | Title11 | Title11 | Title21 | Title31 | Title02 |
    | "Auburn" college photos      | Title02 | Title12 | Title12 | Title22 | Title32 | Title03 |
    | "Auburn" college news        | Title03 | Title13 | Title13 | Title23 | Title33 | Title04 |
    | "Auburn" college stats       | Title04 | Title14 | Title14 | Title24 | Title34 | Title01 |
    | "Auburn" college smacks      | Title02 | Title03 | Title04 | Title12 | Title23 | Title34 |
    | "Auburn" college redemptions | Title11 | Title12 | Title13 | Title01 | Title22 | Title33 |

  Scenario Outline: Listing Conference Posts
    Given I have conferences
    | Conference |
    | SEC        |
    | ACC        |
    And I have confirmed users
    | College        | Affiliation | Username     | First Name | Last Name | Affiliation | Email               | Password  |
    | Auburn         | Fan         | test_user    | Test       | User      | Fan         | test@example.com    | 12345678  |
    | Miami          | Alumni      | test_client  | Test       | Client    | Alumni      | client@example.com  | 87654321  |
    | North Carolina | Student     | test_student | Test       | Student   | Student     | student@example.com | 123456789 |
    And I have posts
    | Type       | Kind  | Conference | Title   | Username  |
    | Smack      | Video | SEC        | Title01 | test_user |
    | Smack      | Photo | SEC        | Title02 | test_user |
    | Smack      | News  | SEC        | Title03 | test_user |
    | Smack      | Stats | SEC        | Title04 | test_user |
    | Redemption | Video | SEC        | Title11 | test_user |
    | Redemption | Photo | SEC        | Title12 | test_user |
    | Redemption | News  | SEC        | Title13 | test_user |
    | Redemption | Stats | SEC        | Title14 | test_user |
    | Smack      | Video | ACC        | Title21 | test_user |
    | Smack      | Photo | ACC        | Title22 | test_user |
    | Smack      | News  | ACC        | Title23 | test_user |
    | Smack      | Stats | ACC        | Title24 | test_user |
    | Redemption | Video | ACC        | Title31 | test_user |
    | Redemption | Photo | ACC        | Title32 | test_user |
    | Redemption | News  | ACC        | Title33 | test_user |
    | Redemption | Stats | ACC        | Title34 | test_user |
    When I am on <Page> page
    Then I should see "<See1>"
    And I should see "<See2>"
    And I should see "<See3>"
    And I should not see "<NotSee1>"
    And I should not see "<NotSee2>"
    And I should not see "<NotSee3>"

    Examples:
    | Page                         | See1    | See2    | See3    | NotSee1 | NotSee2 | NotSee3 |
    | "SEC" conference             | Title01 | Title12 | Title13 | Title21 | Title23 | Title32 |
    | "SEC" conference videos      | Title01 | Title11 | Title11 | Title21 | Title31 | Title02 |
    | "SEC" conference photos      | Title02 | Title12 | Title12 | Title22 | Title32 | Title03 |
    | "SEC" conference news        | Title03 | Title13 | Title13 | Title23 | Title33 | Title04 |
    | "SEC" conference stats       | Title04 | Title14 | Title14 | Title24 | Title34 | Title01 |
    | "SEC" conference smacks      | Title02 | Title03 | Title04 | Title12 | Title23 | Title34 |
    | "SEC" conference redemptions | Title11 | Title12 | Title13 | Title01 | Title22 | Title33 |
