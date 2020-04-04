Feature: Public or Private

   As a journalist
   So that I can manage my data files easily
   I want to make some files public and keep others private

Background: users and datacrunches have been added to database and the user has signed in

    Given the following users exist:
    | username | password |
    | jim123   | columbia |

    And I am on the index page
    Then 1 example users should exist

    Given the following datacrunches exist:
    | title | username | created_at | data_file_name | publicity |
    | datacrunch | jim123 | 2020-03-04 21:38:13 UTC | data1.csv | 1 |
    | dummy | jim123 | 2020-03-04 21:48:13 UTC | data2.csv | 0 |

    And I am on the index page
    Then 2 example datacrunches should exist
    
    # Log in
    Given I am on the index page
    And I type "jim123" as a username
    And I type "columbia" as a password
    When I click the "Log in" button
    Then I should see "jim123"

Scenario: Only public file visible
    Given I am on the index page
    Then I should see row 1 with the name "datacrunch" in column 1
    And I should see 1 data records
    When I click the "Show all datacrunches" button
    Then I should see row 1 with the name "datacrunch" in column 2
    And I should see row 2 with the name "dummy" in column 2 

# Scenario: Viewing a public file
#     Given I am on the index page
#     Then I should see row 1 with the name "datacrunch" in column 1
#     When I click on the More about datacrunch link
    
