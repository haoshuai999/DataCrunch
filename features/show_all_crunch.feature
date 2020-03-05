Feature: View data

   As a journalist
   So that I can manage my data files easily
   I want to see a list showing all the files I upload

Background: users have been added to database

    Given the following users exist:
    | username | password |
    | jim123   | columbia |
    | shuai    | hello |

    And I am on the index page
    Then 2 example user should exist

Scenario: User sign in and click show all
    Given I am on the index page
    And I type "jim123" as a username
    And I type "columbia" as a password
    When I click the "Log in" button
    Then I should see "jim123"
    When I click the "Show all datacrunches" button
    Then I should be redirected to the show all page

Scenario: Show all the data
    Given I am on the show all page
    Then I should see "hello"
    
    
