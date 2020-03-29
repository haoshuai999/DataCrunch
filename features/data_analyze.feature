Feature: Analyze data

    As a journalist
    So that I can see I high level overview of my data
    I want to see the filename, title, description and dimensions of my file 

#Pulled from show_all_crunch.feature
Background: users and datacrunches have been added to database and the user has signed in

    Given the following users exist:
    | username | password |
    | jim123   | columbia |
    | shuai    | hello |

    And I am on the index page
    Then 2 example users should exist

    Given the following datacrunches exist:
    | title | username | created_at | data_file_name |
    | a | jim123 | 2020-03-04 21:38:13 UTC | data1.csv |
    | b | jim123 | 2020-03-04 21:48:13 UTC | data2.csv | 
    | c | shuai  | 2020-03-04 21:28:13 UTC | good.xlsx |
    | d | shuai  | 2020-03-04 21:58:13 UTC | bad.xlsx  |

    And I am on the index page
    Then 4 example datacrunches should exist
    
    # Log in
    Given I am on the index page
    And I type "jim123" as a username
    And I type "columbia" as a password
    When I click the "Log in" button
    Then I should see "jim123"

    # Upload the file for "jim123"
    When I upload a csv file called "data.csv"
    Then I should see "data.csv"
    