require 'uri'
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))


#uses rspec-expectations gem

Given /^(?:I) am on the (.+)$/ do |page_name|
    visit path_to(page_name) 

end



When /^(?:I) upload a (.+) file called "(.+)"$/ do |file_type, file_name|
    attach_file('Upload', 'app/assets/Uploads/'+file_name)
    click_button('Upload')

end

Then /^(?:|I )should see "([^"]*)"$/ do |text|
  if page.respond_to? :should
    page.should have_content(text)
  else
    assert page.has_content?(text)
  end
end