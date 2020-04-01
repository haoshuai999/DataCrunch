Feature: Search data

   As a journalist
   So that I can manage my data files easily
   I want to search for the files I upload

Background: users and datacrunches have been added to database and the user has signed in

    Given the following users exist:
    | username | password |
    | jim123   | columbia |

    And I am on the index page
    Then 1 example users should exist

    Given the following datacrunches exist:
    | title | username | created_at | data_file_name |
    | datacrunch | jim123 | 2020-03-04 21:38:13 UTC | data1.csv |
    | dummy | jim123 | 2020-03-04 21:48:13 UTC | data2.csv | 

    And I am on the index page
    Then 2 example datacrunches should exist
    
    # Log in
    Given I am on the index page
    And I type "jim123" as a username
    And I type "columbia" as a password
    When I click the "Log in" button
    Then I should see "jim123"

    When I click the "Show all datacrunches" button
    Then I should be redirected to the show all page

Scenario: Search successfully
    Given I am on the show all page
    When I type "dummy" in the search bar
    And I click the "Search" button
    Then I should see row 1 with the name "dummy" in column 2
    And I should not see row 1 with the name "datacrunch" in column 2

Scenario: Search unsuccessfully
    Given I am on the show all page
    When I type "apple" in the search bar
    And I click the "Search" button
    Then I should see "Cannot find what you want"