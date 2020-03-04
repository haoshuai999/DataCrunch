require 'uri'
require 'cgi'
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))

module WithinHelpers
    def with_scope(locator)
        locator ? within(locator) { yield } : yield
    end
end
World(WithinHelpers)
  
When /^I click the \"(.*)\" button$/ do |button_name|
    click_button(button_name)
end

Then /^I should be redirected to the (.*)$/ do |page_name|
    visit path_to(page_name)
end

And /^I type (.*) as a (.*)$/ do |user_input, field_name|
    fill_in("user_" + field_name, :with => user_input)
end

And /^I should see (.*) in the username field$/ do |name_output|
    with_scope("#user_username") do
        page.should have_content(name_output)
    end
end