Feature: Posts listing and Search
  In order to view content
  As a user
  I want to be able to view posts in their place and search them
  
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

  Scenario Outline: Conferences Search
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
    | Smack      | Video | SEC        | Title01aa | test_user |
    | Smack      | Photo | SEC        | Title02ab | test_user |
    | Smack      | News  | SEC        | Title03aa | test_user |
    | Smack      | Stats | SEC        | Title04ab | test_user |
    | Redemption | Video | SEC        | Title11aa | test_user |
    | Redemption | Photo | SEC        | Title12ab | test_user |
    | Redemption | News  | SEC        | Title13aa | test_user |
    | Redemption | Stats | SEC        | Title14ab | test_user |
    | Smack      | Video | ACC        | Title21aa | test_user |
    | Smack      | Photo | ACC        | Title22ab | test_user |
    | Smack      | News  | ACC        | Title23aa | test_user |
    | Smack      | Stats | ACC        | Title24ab | test_user |
    | Redemption | Video | ACC        | Title31aa | test_user |
    | Redemption | Photo | ACC        | Title32ab | test_user |
    | Redemption | News  | ACC        | Title33aa | test_user |
    | Redemption | Stats | ACC        | Title34ab | test_user |
    When I am on <Page> page
    And I fill in "search_title_or_summary_contains" with "<Search>"
    And I press "Go"
    Then I should see "<See1>"
    And I should see "<See2>"
    And I should see "<See3>"
    And the "search_title_or_summary_contains" field should contain "<Search>"
    And I should not see "<NotSee1>"
    And I should not see "<NotSee2>"
    And I should not see "<NotSee3>"
    And I should not see "<NotSee4>"
    
    Examples:
    | Page                         | Search   | See1    | See2    | See3    | NotSee1 | NotSee2 | NotSee3 | NotSee4 |
    | "SEC" conference             |          | Title01 | Title12 | Title13 | Title21 | Title23 | Title32 | Title34 |
    | "SEC" conference             | ab       | Title02 | Title04 | Title12 | Title22 | Title24 | Title32 | Title34 |
    | "SEC" conference             | notexist | SEC     | SEC     | SEC     | Title01 | Title12 | Title23 | Title34 |
    | "SEC" conference videos      |          | Title01 | Title11 | Title11 | Title21 | Title31 | Title02 | Title12 |
    | "SEC" conference videos      | 11       | Title11 | Title11 | Title11 | Title01 | Title21 | Title31 | Title02 |
    | "SEC" conference videos      | notexist | SEC     | SEC     | SEC     | Title01 | Title11 | Title31 | Title02 |
    | "SEC" conference photos      |          | Title02 | Title12 | Title12 | Title22 | Title32 | Title03 | Title04 |
    | "SEC" conference photos      | 02       | Title02 | Title02 | Title02 | Title22 | Title32 | Title03 | Title12 |
    | "SEC" conference photos      | notexist | SEC     | SEC     | SEC     | Title02 | Title12 | Title03 | Title22 |
    | "SEC" conference news        |          | Title03 | Title13 | Title13 | Title23 | Title33 | Title04 | Title02 |
    | "SEC" conference news        | 13       | Title13 | Title13 | Title13 | Title23 | Title33 | Title04 | Title03 |
    | "SEC" conference news        | notexist | SEC     | SEC     | SEC     | Title13 | Title33 | Title04 | Title03 |
    | "SEC" conference stats       |          | Title04 | Title14 | Title14 | Title24 | Title34 | Title01 | Title02 |
    | "SEC" conference stats       | 04       | Title04 | Title04 | Title04 | Title24 | Title34 | Title01 | Title14 |
    | "SEC" conference stats       | notexist | SEC     | SEC     | SEC     | Title14 | Title34 | Title01 | Title04 |
    | "SEC" conference smacks      |          | Title02 | Title03 | Title04 | Title12 | Title23 | Title34 | Title13 |
    | "SEC" conference smacks      | aa       | Title01 | Title03 | Title03 | Title02 | Title04 | Title12 | Title23 |
    | "SEC" conference smacks      | notexist | SEC     | SEC     | SEC     | Title01 | Title02 | Title03 | Title04 |
    | "SEC" conference redemptions |          | Title11 | Title12 | Title13 | Title01 | Title22 | Title33 | Title02 |
    | "SEC" conference redemptions | ab       | Title12 | Title14 | Title14 | Title11 | Title13 | Title01 | Title02 |
    | "SEC" conference redemptions | notexist | SEC     | SEC     | SEC     | Title11 | Title12 | Title13 | Title14 |

  Scenario Outline: Colleges Search
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
    | Type       | Kind  | College | Title     | Username  |
    | Smack      | Video | Auburn  | Title01aa | test_user |
    | Smack      | Photo | Auburn  | Title02ab | test_user |
    | Smack      | News  | Auburn  | Title03aa | test_user |
    | Smack      | Stats | Auburn  | Title04ab | test_user |
    | Redemption | Video | Auburn  | Title11aa | test_user |
    | Redemption | Photo | Auburn  | Title12ab | test_user |
    | Redemption | News  | Auburn  | Title13aa | test_user |
    | Redemption | Stats | Auburn  | Title14ab | test_user |
    | Smack      | Video | Miami   | Title21aa | test_user |
    | Smack      | Photo | Miami   | Title22ab | test_user |
    | Smack      | News  | Miami   | Title23aa | test_user |
    | Smack      | Stats | Miami   | Title24ab | test_user |
    | Redemption | Video | Miami   | Title31aa | test_user |
    | Redemption | Photo | Miami   | Title32ab | test_user |
    | Redemption | News  | Miami   | Title33aa | test_user |
    | Redemption | Stats | Miami   | Title34ab | test_user |
    When I am on <Page> page
    And I fill in "search_title_or_summary_contains" with "<Search>"
    And I press "Go"
    Then I should see "<See1>"
    And I should see "<See2>"
    And I should see "<See3>"
    And the "search_title_or_summary_contains" field should contain "<Search>"
    And I should not see "<NotSee1>"
    And I should not see "<NotSee2>"
    And I should not see "<NotSee3>"
    And I should not see "<NotSee4>"
    
    Examples:
    | Page                         | Search   | See1    | See2    | See3    | NotSee1 | NotSee2 | NotSee3 | NotSee4 |
    | "Auburn" college             |          | Title01 | Title12 | Title13 | Title21 | Title23 | Title32 | Title34 |
    | "Auburn" college             | ab       | Title02 | Title04 | Title12 | Title22 | Title24 | Title32 | Title34 |
    | "Auburn" college             | notexist | Auburn  | Auburn  | Auburn  | Title01 | Title12 | Title23 | Title34 |
    | "Auburn" college videos      |          | Title01 | Title11 | Title11 | Title21 | Title31 | Title02 | Title12 |
    | "Auburn" college videos      | 11       | Title11 | Title11 | Title11 | Title01 | Title21 | Title31 | Title02 |
    | "Auburn" college videos      | notexist | Auburn  | Auburn  | Auburn  | Title01 | Title11 | Title31 | Title02 |
    | "Auburn" college photos      |          | Title02 | Title12 | Title12 | Title22 | Title32 | Title03 | Title04 |
    | "Auburn" college photos      | 02       | Title02 | Title02 | Title02 | Title22 | Title32 | Title03 | Title12 |
    | "Auburn" college photos      | notexist | Auburn  | Auburn  | Auburn  | Title02 | Title12 | Title03 | Title22 |
    | "Auburn" college news        |          | Title03 | Title13 | Title13 | Title23 | Title33 | Title04 | Title02 |
    | "Auburn" college news        | 13       | Title13 | Title13 | Title13 | Title23 | Title33 | Title04 | Title03 |
    | "Auburn" college news        | notexist | Auburn  | Auburn  | Auburn  | Title13 | Title33 | Title04 | Title03 |
    | "Auburn" college stats       |          | Title04 | Title14 | Title14 | Title24 | Title34 | Title01 | Title02 |
    | "Auburn" college stats       | 04       | Title04 | Title04 | Title04 | Title24 | Title34 | Title01 | Title14 |
    | "Auburn" college stats       | notexist | Auburn  | Auburn  | Auburn  | Title14 | Title34 | Title01 | Title04 |
    | "Auburn" college smacks      |          | Title02 | Title03 | Title04 | Title12 | Title23 | Title34 | Title13 |
    | "Auburn" college smacks      | aa       | Title01 | Title03 | Title03 | Title02 | Title04 | Title12 | Title23 |
    | "Auburn" college smacks      | notexist | Auburn  | Auburn  | Auburn  | Title01 | Title02 | Title03 | Title04 |
    | "Auburn" college redemptions |          | Title11 | Title12 | Title13 | Title01 | Title22 | Title33 | Title02 |
    | "Auburn" college redemptions | ab       | Title12 | Title14 | Title14 | Title11 | Title13 | Title01 | Title02 |
    | "Auburn" college redemptions | notexist | Auburn  | Auburn  | Auburn  | Title11 | Title12 | Title13 | Title14 |

  Scenario Outline: User Search
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
    | Type       | Kind  | Conference | College | Title       | Username    |
    | Smack      | Video | SEC        |         | TitleSVS-aa | test_user   |
    | Smack      | Photo | SEC        |         | TitleSPS-ab | test_user   |
    | Smack      | News  | SEC        |         | TitleSNS-aa | test_client |
    | Smack      | Stats | SEC        |         | TitleSSS-ab | test_user   |
    | Redemption | Video | SEC        |         | TitleRVS-aa | test_user   |
    | Redemption | Photo | SEC        |         | TitleRPS-ab | test_client |
    | Redemption | News  | SEC        |         | TitleRNS-aa | test_user   |
    | Redemption | Stats | SEC        |         | TitleRSS-ab | test_user   |
    | Smack      | Video | ACC        |         | TitleSVA-aa | test_client |
    | Smack      | Photo | ACC        |         | TitleSPA-ab | test_user   |
    | Smack      | News  | ACC        |         | TitleSNA-aa | test_user   |
    | Smack      | Stats | ACC        |         | TitleSSA-ab | test_client |
    | Redemption | Video | ACC        |         | TitleRVA-aa | test_user   |
    | Redemption | Photo | ACC        |         | TitleRPA-ab | test_user   |
    | Redemption | News  | ACC        |         | TitleRNA-aa | test_client |
    | Redemption | Stats | ACC        |         | TitleRSA-ab | test_user   |
    | Smack      | Video |            | Auburn  | TitleSVU-aa | test_user   |
    | Smack      | Photo |            | Auburn  | TitleSPU-ab | test_client |
    | Smack      | News  |            | Auburn  | TitleSNU-aa | test_user   |
    | Smack      | Stats |            | Auburn  | TitleSSU-ab | test_user   |
    | Redemption | Video |            | Auburn  | TitleRVU-aa | test_client |
    | Redemption | Photo |            | Auburn  | TitleRPU-ab | test_user   |
    | Redemption | News  |            | Auburn  | TitleRNU-aa | test_user   |
    | Redemption | Stats |            | Auburn  | TitleRSU-ab | test_client |
    | Smack      | Video |            | Miami   | TitleSVM-aa | test_user   |
    | Smack      | Photo |            | Miami   | TitleSPM-ab | test_user   |
    | Smack      | News  |            | Miami   | TitleSNM-aa | test_client |
    | Smack      | Stats |            | Miami   | TitleSSM-ab | test_user   |
    | Redemption | Video |            | Miami   | TitleRVM-aa | test_user   |
    | Redemption | Photo |            | Miami   | TitleRPM-ab | test_client |
    | Redemption | News  |            | Miami   | TitleRNM-aa | test_user   |
    | Redemption | Stats |            | Miami   | TitleRSM-ab | test_user   |
    And user signed in as "test@example.com" with "12345678"
    When I am on <Page> page
    And I fill in "search_title_or_summary_contains" with "<Search>"
    And I press "Go"
    Then I should see "<See1>"
    And I should see "<See2>"
    And I should see "<See3>"
    And I should see "<See4>"
    And the "search_title_or_summary_contains" field should contain "<Search>"
    And I should not see "<NotSee1>"
    And I should not see "<NotSee2>"
    And I should not see "<NotSee3>"
    And I should not see "<NotSee4>"
    
    Examples:
    | Page                         | Search   | See1     | See2     | See3     | See4     | NotSee1  | NotSee2  | NotSee3  | NotSee4  |
    | "test_user" user             |          | TitleSVS | TitleSPA | TitleRNU | TitleRSM | TitleSNS | TitleRNA | TitleRVU | TitleSNM |
    | "test_user" user             | ab       | TitleSPS | TitleRPA | TitleSSU | TitleRSM | TitleSVS | TitleRVS | TitleSNU | TitleRVU |
    | "test_user" user             | notexist | Posts    | Posts    | Posts    | Posts    | TitleSVS | TitleRSS | TitleSNU | TitleSPM |
    | "test_user" user smacks      |          | TitleSVS | TitleSPA | TitleSNU | TitleSSM | TitleSNS | TitleRNS | TitleRPA | TitleRPU |
    | "test_user" user smacks      | aa       | TitleSVS | TitleSNA | TitleSVU | TitleSVM | TitleSPS | TitleSPA | TitleRNA | TitleSSM |
    | "test_user" user smacks      | notexist | Posts    | Posts    | Posts    | Posts    | TitleSVS | TitleSPA | TitleSNU | TitleSSM |
    | "test_user" user redemptions |          | TitleRVS | TitleRPA | TitleRNU | TitleRSM | TitleSPS | TitleSNA | TitleSSU | TitleSSM |
    | "test_user" user redemptions | ab       | TitleRSS | TitleRPA | TitleRPU | TitleRSM | TitleRVS | TitleRVA | TitleRNU | TitleRNM |
    | "test_user" user redemptions | notexist | Posts    | Posts    | Posts    | Posts    | TitleRVS | TitleRPA | TitleRNU | TitleRSM |
    
