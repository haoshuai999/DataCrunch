Feature: Sign in

   As a journalist
   So that I can maintain my work on the site
   I want to be able to log in

Scenario: User Sign in
    Given I am on the index page
    And there is an account called "journo_guy" with the password "pulitzer"
    When I enter the username "journo_guy" into the username field
    And I enter the password "pulitzer" into the password field
    Then I should see "journo_guy"

Scenario: Create User I
    Given I am on the index page
    When I click create new user
    Then I should be redirected to the create user page

Scenario: Create User II
    Given I am on the create user page
    When I type "jim123" as a username
    And I type "columbia" as a password
    Then I should be redirected to the index page
    And I should see "jim123" 
