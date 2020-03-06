require 'uri'
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))
require 'csv'

When /^(?:I) click the (.*) link$/ do |link_name|
    click_link(link_name)
end


And /^(?:I) should see my columns from (.+)$/ do |data_file|
    file = Datacrunch.find_by! data_file_name: data_file
    
    path = File.join Rails.root, 'public'
    columns = CSV.read(File.join(path,file.data.url)).take(1)[0]
    page.has_content?(columns)
   
end