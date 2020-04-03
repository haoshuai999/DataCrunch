require 'uri'
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))
require 'csv'
require "#{Rails.root}/lib/dataframe.rb"

And("I click on column {int}") do |int|
    column = page.all(".colname").values_at(int)
    # puts page.html
    click_link(column[0].text)

    
end

Then("I should see the summary stats of column {int}") do |int|
    puts page.html # Write code here that turns the phrase above into concrete actions
end