require 'uri'
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))

When /^I click the \"(.*)\" button to delete the file on the row (.*)$/ do |button_name, row_num|
    with_scope("tr:nth-child(#{row_num}) td:nth-child(1)") do
        click_button(button_name)
    end
end