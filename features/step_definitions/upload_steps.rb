require 'uri'
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))

Given /^(?:I) am on the (.+)$/ do |page_name|
    visit path_to(page_name) 

end

When /^(?:I) upload a (.+) file$/ do |file_type|
    #Creating an entry in the 
end

Then 