require 'uri'
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))

And /^I should see (.*) data records$/ do |record_num|
    page.should have_selector('tr', count: (record_num.to_i + 1))
end