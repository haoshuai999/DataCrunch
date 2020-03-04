require 'uri'
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))

When /^I click the \"(.*)\" button$/ do |button_name|
    click_button(button_name)
end

Then /^I should be redirected to the (.*) page$/ do |page_name|
    visit path_to(page_name)
end