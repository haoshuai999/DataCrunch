require 'uri'
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))

module WithinHelpers
    def with_scope(locator)
      locator ? within(locator) { yield } : yield
    end
  end
World(WithinHelpers)

Given /the following datacrunches exist/ do |datacrunches_table|
    datacrunches_table.hashes.each do |crunch|
        Datacrunch.create!(:title => crunch[:title], :username => crunch[:username], :created_at => crunch[:created_at])
    end
end

Then /^(.*) example datacrunches should exist$/ do | n_seeds |
    Datacrunch.count.should be n_seeds.to_i
end

Then /^I should see (.*) files uploaded by \"(.*)\"$/ do |file_number, user_name|
    with_scope("tbody") do
        page.should have_selector('tr', count: file_number)
        page.should have_content(user_name)
    end
end

Then /^I should not see files uploaded by \"(.*)\"$/ do |user_name|
    with_scope("tbody") do
        page.should have_no_content(user_name)
    end
end

When /^I click the link of the \"(.*)\" file$?/ do |file_name| 
    link = page.find('tr', :text => file_name)
    link_id = link.find_link[:id]
    click_link(link_id)
end
