Feature: View data properties

   As a journalist
   So that I can understand my data
   I want to see the filename, title, description, author and dimensions of my data

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
    Then I should see the filename, title, description, author and dimensions of "data.csv"
    
Scenario: Upload json
    Given I upload a json file called "data.json"
    When I click the here link
    Then I should see the filename, title, description, author and dimensions of "data.json"

Scenario: Upload xlsx
    Given I upload a xlsx file called "data.xlsx"
    When I click the here link
    Then I should see the filename, title, description, author and dimensions of "data.xlsx"
    
