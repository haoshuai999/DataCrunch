Feature: Upload File

   As a journalist
   So that I can see my data
   I want to upload a file

Scenario: Upload csv
    Given I am on the index page
    When I upload a csv file called "data.csv"
    Then I should see "data.csv"

Scenario: Upload json
    Given I am on the index page
    When I upload a json file called "data.json"
    Then I should see "data.json"

Scenario: Upload xlsx
    Given I am on the index page
    When I upload a xlsx file called "data.xlsx"
    Then I should see "data.xslx"
