require 'uri'
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))

When /^I type \"(.*)\" in the search bar$/ do |search_term| 
    fill_in 'search', :with => search_term
end

Then /^I should see row (.*) with the name \"(.*)\" in column (.*)$/ do |row_num, file_name, column_num|
    with_scope("tr:nth-child(#{row_num}) td:nth-child(#{column_num})") do
        page.should have_content(file_name)
    end
end

And /^I should not see row (.*) with the name \"(.*)\" in column (.*)$/ do |row_num, file_name, column_num|
    with_scope("tr:nth-child(#{row_num}) td:nth-child(#{column_num})") do
        page.should have_no_content(file_name)
    end
end