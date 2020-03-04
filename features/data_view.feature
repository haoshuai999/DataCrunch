Feature: View data

   As a journalist
   So that I can see my data
   I want to see the columns and rows of my dataset

Scenario: Upload csv
    Given I have uploaded a csv
    When I click view
    Then I should be redirected to the view page
    And I should see my columns and rows

Scenario: Upload json
    Given I have uploaded a json
    When I click view
    Then I should be redirected to the view page
    And I should see my columns and rows

Scenario: Upload xlsx
    Given I have uploaded a csv
    When I click view
    Then I should be redirected to the view page
    And I should see my columns and rows
