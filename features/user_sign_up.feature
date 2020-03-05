Feature: Sign up

   As a journalist
   So that I can maintain my work on the site
   I want to be able to sign up a new account

Scenario: User Sign up
    Given I am on the index page
    When I click the "Sign up" button
    Then I should be redirected to the create user page

Scenario: Create User
    Given I am on the create user page
    And I type "jim123" as a username
    And I type "columbia" as a password
    When I click the "Submit" button
    Then I should be redirected to the index page
    And I should see "jim123" in the username field