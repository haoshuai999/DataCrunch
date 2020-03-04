Feature: Sign in

   As a journalist
   So that I can maintain my work on the site
   I want to be able to log in

Scenario: User successfully sign in
    Given I am on the index page
    And there is an account called "journo_guy" with the password "pulitzer"
    When I enter the username "journo_guy" into the username field
    And I enter the password "pulitzer" into the password field
    Then I should see "journo_guy" in the nav bar
