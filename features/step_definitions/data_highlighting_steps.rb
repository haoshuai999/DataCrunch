require 'uri'
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))

Then /^I should see (.*) "(.*)" percent cells highlighted$/ do |num_cells, percentage|
    # puts num_cells
    if num_cells.to_i == 0
        expect(page).not_to have_css('.' + percentage)
    else 
        expect(page).to have_css('.' + percentage, count: num_cells.to_i) 
    end 
    
end 