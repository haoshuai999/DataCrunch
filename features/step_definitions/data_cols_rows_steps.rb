Then /^(?:I) should see (.*) columns from \"(.*)\"$/ do |colnum, data_file|
    id = page.current_url.split("/")[-1]
    
    datacrunch = Datacrunch.find_by! data_file_name: data_file, id: id
    dataframe = Dataframe.new(datacrunch)
    columns = dataframe.dataframe.vectors.to_a[0..colnum.to_i - 1]
    page.has_content?(columns)
   
end

And /^(?:I) should see (.*) rows from \"(.*)\"$/ do |rownum, data_file|
    id = page.current_url.split("/")[-1]
    
    datacrunch = Datacrunch.find_by! data_file_name: data_file, id: id
    dataframe = Dataframe.new(datacrunch)
    rows = dataframe.dataframe[0..rownum.to_i - 1].to_a
    page.has_content?(rows)
   
end


And /^the "(.+)" button should be (.+)$/ do |button_name, enabled|

    expect(page).to have_button(button_name, disabled: true) if enabled == "disabled"
    expect(page).to have_button(button_name, disabled: false) if enabled == "enabled"

end  