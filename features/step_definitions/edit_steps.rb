require 'uri'
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))

When /^I click the \"(.*)\" button to edit the file on the row (.*)$/ do |button_name, row_num|
    with_scope("tr:nth-child(#{row_num}) td:nth-last-child(1)") do
        click_button(button_name)
    end
end

Given /^I am editing the file with id (.*)$/ do |file_id|
    visit "/datacrunches/#{file_id}/edit"
end