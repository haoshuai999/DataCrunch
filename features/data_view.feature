Feature: View data

   As a journalist
   So that I can see my data
   I want to see the columns and rows of my dataset

Scenario: Upload csv
    Given I am on the index page
    Given I upload a csv file called "data.csv"
    When I click the here link
    And I should see my columns from "data.csv"

Scenario: Upload json
    Given I am on the index page
    Given I upload a json file called "data.json"
    When I click the here link
    And I should see my columns from "data.json"

Scenario: Upload xlsx
    Given I am on the index page
    Given I upload a xlsx file called "data.xlsx"
    When I click the here link
    And I should see my columns from "data.xlsx"
