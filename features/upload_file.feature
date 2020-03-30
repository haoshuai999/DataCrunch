Feature: Upload File

   As a journalist
   So that I can see my data
   I want to upload a file

Background: users have been added to database

    Given the following users exist:
    | username | password |
    | jim123   | columbia |

    And I am on the index page
    Then 1 example users should exist

Scenario: Upload csv
    Given I am on the index page
    When I upload a csv file called "data.csv"
    Then I should see "data.csv"

Scenario: Upload json as a private file
    Given I am on the index page
    When I upload a json file called "data.json"
    Then I should see "data.json"

Scenario: Upload xlsx
    Given I am on the index page
    When I upload a xlsx file called "data.xlsx"
    Then I should see "data.xlsx"

Scenario: Upload csv as a public file
    # Log in
    Given I am on the index page
    And I type "jim123" as a username
    And I type "columbia" as a password
    When I click the "Log in" button
    Then I should see "jim123"

    Given I am on the index page
    And I want the file to be public
    When I upload a csv file called "data.csv"
    Then I should see "data.csv"
    And I should see 1 data records

Scenario: Upload json as a private file
    # Log in
    Given I am on the index page
    And I type "jim123" as a username
    And I type "columbia" as a password
    When I click the "Log in" button
    Then I should see "jim123"

    Given I am on the index page
    And I want the file to be private
    When I upload a json file called "data.json"
    Then I should see "data.json"
    And I should see 0 data records