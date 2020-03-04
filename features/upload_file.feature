Feature: Upload File

   As a journalist
   So that I can see my data
   I want to upload a file

Scenario: Upload csv
    Given I am on the index page
    When I upload a csv file called "data.csv"
    # When I select the "browse" button
    # And I select csv file called "data.csv"
    # And I click the "upload" button
    Then I should see "data.csv"

Scenario: Upload json
    Given I am on the index page
    When I upload a json file called "data.json"
    # When I select the "browse" button
    # And I select json file called "data.json"
    # And I click the "upload" button
    Then I should see "data.json"

Scenario: Upload xlsx
    Given I am on the index page
    When I upload a xlsx file called "data.xlsx"
    # When I select the "browse" button
    # And I select xlsx file called "data.xlsx"
    # And I click the "upload" button
    Then I should see "data.xlsx"
