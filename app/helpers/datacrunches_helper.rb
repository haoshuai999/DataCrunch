



module DatacrunchesHelper
    require 'csv'
    require 'roo'
    require 'json'
    require 'json_converter'
    require "#{Rails.root}/lib/dataframe.rb"

   
    
    ####################################################
    # UNUSED 
    ###################################################    
    # def display_file(datacrunch, ncols, nrows)
    #     #Returns csv of the data the use uploaded, limited by nrows and nrows
    #     # For faster processing, we should put 
    #     path = File.join Rails.root, 'public'
    #     file_path_with_timestamp = File.join(path,datacrunch.data.url)
    #     file_ext = File.extname(datacrunch.data.url).downcase.split("?")[0]
    #     file_path = file_path_with_timestamp.split("?")[0]
    #     case file_ext
    #     when ".csv"
    #         data = handle_csv(file_path)
    #     when ".xlsx", ".xls"
    #         data = handle_excel(file_path)
    #     when ".json"
    #         data = handle_json(file_path)
    #     end

    #     trunc_data = truncate_data(data, ncols, nrows)

    #     return trunc_data
    # end


    # def handle_csv(file_path)
    #     data_array = []
    #     csv = CSV.read(file_path)
    #     puts csv
    #     return csv
    # end

    # def handle_excel(file_path)
    #     xls_file = Roo::Excelx.new(file_path)
    #     csv = CSV.parse(xls_file.to_csv)
    #     # puts CSV.parse(csv)
        
    #     return csv
    # end

    # def handle_json(file_path)
    #     json_file = JSON.parse(File.open(file_path).read)
    #     json_converter = JsonConverter.new
    #     csv_json = json_converter.generate_csv json_file
    #     csv = CSV.parse(csv_json)
       
    #     return csv
    # end

    # def truncate_data(data, ncols, nrows)
    
    #     trunc_data = data[0..nrows] #Limit number of rows

    #     trunc_data.each_with_index do |row, index|
    #         trunc_data[index] = row[0..ncols-1] #-1 to since functionally column index starts at 0 instead of 1 for rows
    #     end 

    #     return trunc_data
    # end 


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
    
    def vector_to_json(vector)
        #takes a daru vector and spits out a json
        json = vector.to_json
        puts json
    end 
  



end
