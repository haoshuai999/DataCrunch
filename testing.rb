require 'daru'
require 'daru/io/importers'

require 'json'

# require 'jsonconverter'
# require "#{Rails.root}/lib/dataframe.rb"


def calc_datacrunch_size(file_size)
    #file_size comes in in bytes, need to convert to readable format
    #print bytes, kb, mb and gb
    num_digits = file_size.to_s.length

    if num_digits < 3    
        converted_size = file_size.to_s + " Bytes"
    elsif num_digits >= 3 && num_digits < 6
        to_kb = (file_size.to_f/1000).round(2)
        converted_size = to_kb.to_s + " KB"
    elsif num_digits >= 6 && num_digits < 9
        to_mb = (file_size.to_f/1000000).round(2)
        converted_size = to_mb.to_s + " MB"
    elsif num_digits >= 9 && num_digits < 12
        to_mb = (file_size.to_f/1000000000).round(2)
        converted_size = to_mb.to_s + " GB"
    #Can add more if statements to handle larger files
    end
  

    return converted_size
end

def calc_datacrunch_dimensions(csv)
    #Takes a csv object (hopefully) and spits out dimensions of the 
    test = df.shape
    puts test
    
    dimensions = ""
    return dimensions
end

def vector_to_json(vector)
    json = vector.to_json
    puts json
end 



# file_size = 1231231231
# converted_size = calc_datacrunch_size(file_size)


df_csv = Daru::DataFrame.read_csv('FanGraphs Leaderboard.csv', liberal_parsing: true) #Reading a csv
df_excel = Daru::DataFrame.read_excel('mock_data.xlsx').call(sheet: 0) 

puts df_csv.vectors.to_a[0..9]


# # puts df_csv['Team']


# dv = Daru::Vector.new df_csv['Team'], type: :category

# vector_to_json(dv.describe)

