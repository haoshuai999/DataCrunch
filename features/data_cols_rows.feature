Feature: View data properties

   As a journalist
   So that I can search through my data
   I want to change the column and row dimensions of my data

Background: I am signed in
    
    Given the following users exist:
    | username | password |
    | jim123   | columbia |
    | shuai    | hello |

    And I am on the index page
    And I type "jim123" as a username
    And I type "columbia" as a password
    When I click the "Log in" button
    Then I should see "jim123"


Scenario: Upload csv
    Given I upload a csv file called "data.csv"
    When I click the here link
    Then I should see 3 columns from "data.csv"
    And I should see 3 rows from "data.csv" 
    And the "More columns" button should be disabled
    And the "Fewer columns" button should be disabled
    And the "More rows" button should be disabled
    And the "Fewer rows" button should be disabled

Scenario: Upload json
    Given I upload a json file called "data.json"
    When I click the here link
    Then I should see 10 columns from "data.json"
    And I should see 10 rows from "data.json"
    When I click the "More columns" button
    Then I should see 14 columns from "data.json"
    And the "More columns" button should be disabled
    And the "Fewer columns" button should be enabled
    When I click the "Fewer columns" button
    Then I should see 10 columns from "data.json"
    And the "More columns" button should be enabled
    And the "Fewer columns" button should be disabled
    When I click the "More rows" button
    Then I should see 15 rows from "data.json" 
    And the "More rows" button should be disabled
    And the "Fewer rows" button should be enabled
    When I click the "Fewer rows" button
    Then I should see 10 rows from "data.json"
    And the "More rows" button should be enabled
    And the "Fewer rows" button should be disabled

Scenario: Upload xlsx
    Given I upload a xlsx file called "data.xlsx"
    When I click the here link
    Then I should see 10 columns from "data.xlsx"
    And I should see 10 rows from "data.xlsx"
    When I click the "More columns" button
    Then I should see 14 columns from "data.xlsx"
    And the "More columns" button should be disabled
    And the "Fewer columns" button should be enabled
    When I click the "More rows" button
    Then I should see 20 rows from "data.xlsx" 
    And the "More rows" button should be enabled
    And the "Fewer columns" button should be enabled

