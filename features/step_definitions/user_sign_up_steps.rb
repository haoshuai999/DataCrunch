require 'uri'
require 'cgi'
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))
  
When /^I click the \"(.*)\" button$/ do |button_name|
    click_button(button_name)
end

Then /^I should be redirected to the (.*) page$/ do |page_name|
    page.current_url == path_to(page_name)
end

And /^I type \"(.*)\" as a (.*)$/ do |user_input, field_name|
    if field_name == "title"
        fill_in("datacrunch_" + field_name, :with => user_input)
    else
        fill_in("user_" + field_name, :with => user_input)
    end
end

And /^I should see \"(.*)\" in the username field$/ do |name_output|
    page.should have_content(name_output)
end