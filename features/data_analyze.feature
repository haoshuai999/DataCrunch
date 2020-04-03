Feature: Analyze data

    As a journalist
    So that I can see I high level overview of my data
    I want to see the filename, title, description and dimensions of my file 

#first three steps of each scenario outlined in data_view_steps

Scenario: CSV Analysis
    Given I am on the index page
    Given I upload a csv file called "data.csv"
    When I click the here link
    And I click on column 1
    Then I should see the summary stats of column 1

Scenario: Excel Analysis
    Given I am on the index page
    Given I upload a excel file called "data.csv"
    When I click the here link
    And I click on column 1
    Then I should see the summary stats of column 1

Scenario: JSON Analysis
    Given I am on the index page
    Given I upload a csv file called "data.json"
    When I click the here link
    And I click on column 1
    Then I should see the summary stats of column 1