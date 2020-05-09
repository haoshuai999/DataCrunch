Feature: View data properties

   As a journalist
   So that I can understand my data
   I want to see my data highlighted

Scenario: Upload csv
    Given I am on the index page
    And I upload a csv file called "data.csv"
    When I click the here link
    Then I should see 0 "bottom_point_one" percent cells highlighted
    And I should see 0 "bottom_two" percent cells highlighted
    And I should see 0 "top_two" percent cells highlighted
    And I should see 0 "top_point_one" percent cells highlighted


Scenario: Upload json
    Given I am on the index page
    And I upload a json file called "data.json"
    When I click the here link
    Then I should see 0 "bottom_point_one" percent cells highlighted
    And I should see 0 "bottom_two" percent cells highlighted
    And I should see 0 "top_two" percent cells highlighted
    And I should see 1 "top_point_one" percent cells highlighted

Scenario: Upload xlsx
    Given I am on the index page
    And I upload a xlsx file called "data.xlsx"
    When I click the here link
    Then I should see 0 "bottom_point_one" percent cells highlighted
    And I should see 0 "bottom_two" percent cells highlighted
    And I should see 1 "top_two" percent cells highlighted
    And I should see 4 "top_point_one" percent cells highlighted