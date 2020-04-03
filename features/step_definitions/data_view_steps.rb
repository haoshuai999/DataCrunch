require 'uri'
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))
require 'csv'
require "#{Rails.root}/lib/dataframe.rb"

When /^(?:I) click the (.*) link$/ do |link_name|
    click_link(link_name)
end

#Unused and broken
# Then /^(?:I) should be on the datacrunches path$/ do
#     expect(page).to have_current_path(datacrunches_path, ignore_query: true)
# end 

And /^(?:I) should see my first 10 columns from "(.+)"$/ do |data_file|
    id = page.current_url.split("/")[-1]
    
    datacrunch = Datacrunch.find_by! data_file_name: data_file, id: id
    dataframe = Dataframe.new(datacrunch)
    ten_columns = dataframe.dataframe.vectors.to_a[0..9]
    page.has_content?(ten_columns)
   
end

And /^(?:I) should see the filename, title, description and dimensions of "(.+)"$/ do |data_file|
    id = page.current_url.split("/")[-1]
    datacrunch = Datacrunch.find_by! data_file_name: data_file, id: id
    dataframe = Dataframe.new(datacrunch)
    
    #Does it have filename?
    page.has_content?(datacrunch.data_file_name)

    #Does it have title?
    page.has_content?(datacrunch.title)

    #Does it have discription?
    page.has_content?(datacrunch.description)

    #Does it have dimentions?
    page.has_content?(dataframe.ncols)
    page.has_content?(dataframe.nrows)


end 

def display_file(datacrunch)
    # puts datacrunch.data.methods
    path = File.join Rails.root, 'public'
    file_path_with_timestamp = File.join(path,datacrunch.data.url)
    file_ext = File.extname(datacrunch.data.url).downcase.split("?")[0]
    file_path = file_path_with_timestamp.split("?")[0]
    case file_ext
    when ".csv"
        data = handle_csv(file_path)
    when ".xlsx", ".xls"
        data = handle_excel(file_path)
    when ".json"
        data = handle_json(file_path)
    end
    

    return data
end


def handle_csv(file_path)
    data_array = []
    csv = CSV.read(file_path)
    
    return csv
end

def handle_excel(file_path)
    xls_file = Roo::Excelx.new(file_path)
    csv = CSV.parse(xls_file.to_csv)
    # puts CSV.parse(csv)
    return csv
end

def handle_json(file_path)
    json_file = JSON.parse(File.open(file_path).read)
    
    json_converter = JsonConverter.new
    csv_json = json_converter.generate_csv json_file
    csv = CSV.parse(csv_json)
    
    return csv
end