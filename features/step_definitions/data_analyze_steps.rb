require 'uri'
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))
require 'csv'
require "#{Rails.root}/lib/dataframe.rb"


And("I click on column {int}") do |int|
    column = page.all(".colname").values_at(int)


    click_link(column[0].text)

    
end

Then("I should see the summary stats of column {int}") do |int|
    id = page.current_url.split("=")[-1]
    
    datacrunch = Datacrunch.find(id)
    dataframe = Dataframe.new(datacrunch)
   
    col_names = dataframe.dataframe.vectors.to_a
    
    stats = dataframe.describe(col_names[int]).to_a

    page.has_content?(stats)
    
    
end



