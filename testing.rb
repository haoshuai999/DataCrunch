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


# df_csv = Daru::DataFrame.read_csv('FanGraphs Leaderboard.csv', liberal_parsing: true) #Reading a csv
# # df_excel = Daru::DataFrame.read_excel('mock_data.xlsx').call(sheet: 0) 

# colored_df = Daru::DataFrame.new([], order: df_csv.vectors.to_a)

# df_csv.vectors.to_a.each do |colname|
#     if df_csv[colname].type == :numeric
#         stats = df_csv[colname].describe
#         stdev = stats[:std]
#         mean = stats[:mean]
#         # puts colname
#         # puts "stddev: " + stdev.to_s
#         # puts "mean: " + mean.to_s
#         df_csv[colname].each_with_index do |rowval,index| #replace first number with num of rows 
#             # puts "value: " + rowval.to_s
#             stddevs_from_the_mean  = ((rowval-mean)/stdev).to_i
#             colored_df[colname][index] = stddevs_from_the_mean
#             # puts index
#         end 

#     else #Fill column rows with 0's  
#         colored_df[colname] = Array.new(df_csv.nrows, 0)
#     end  
# end 

# # puts df_csv['Team']
samples = 1000

a = Daru::Vector.new_with_size(samples) {r=rand(5); r==4 ? nil: r}



puts a

a.delete_if do |val|
    val.nil?
end 

puts a.describe

# puts a.describe

