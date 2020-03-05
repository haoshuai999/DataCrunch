Feature: Sign in

   As a journalist
   So that I can maintain my work on the site
   I want to be able to log in

Scenario: User fails to sign in
    Given I am on the index page
    And I type "aaron123" as a username
    And I type "columbia" as a password
    When I click the "Log in" button
    Then I should see "Cannot find the user"

Scenario: User successfully sign in
    Given I am on the index page
    And I type "jim123" as a username
    And I type "columbia" as a password
    When I click the "Log in" button
    Then I should see "jim123"
