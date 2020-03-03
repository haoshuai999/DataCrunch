Feature: Upload File

   As a journalist
   So that I can see my data
   I want to upload a file

Scenario: Upload csv
    Given I am on the index page
    When I upload a csv file
    Then I should see my file

Scenario: Upload json
    Given I am on the index page
    When I upload a json file
    Then I should see my file

Scenario: Upload xlsx
    Given I am on the index page
    When I upload a xlsx file
    Then I should see my file
