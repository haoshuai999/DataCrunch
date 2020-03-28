require 'uri'
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))

When /^I type \"(.*)\" in the search bar$/ do |search_term| 
    fill_in 'search', :with => search_term
end

Then /^I should see a row with the name \"(.*)\" in the title field$/ do |file_name|
    with_scope("tr:nth-child(1) td:nth-child(2)") do
        page.should have_content(file_name)
    end
end

And /^I should not see a row with the name \"(.*)\" in the title field$/ do |file_name|
    with_scope("tr:nth-child(1) td:nth-child(2)") do
        page.should have_no_content(file_name)
    end
end