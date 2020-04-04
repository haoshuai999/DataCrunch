require 'uri'
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))

Given /the following users exist/ do |users_table|
    users_table.hashes.each do |user|
        User.create!(:username => user[:username], :password => user[:password])
    end
end

Then /^(.*) example users should exist$/ do | n_seeds |
    User.count.should be n_seeds.to_i
end