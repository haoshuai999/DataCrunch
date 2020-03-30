module DatacrunchesHelper
    require 'csv'
    require 'roo'
    require 'json'
    require 'json_converter'
    require 'pandas'
    

    
    
    
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

        return data #Returns csv of the data the use uploaded
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

    def calc_datacrunch_dimensions(data)
        columns = data[0].length
        rows =  data[1..-1].length
        # puts columns
        # puts rows
        # puts "#{columns} columns and #{rows}"
        return "#{columns} columns and #{rows} rows"
    end


    # def csv_to_df(csv)
    #     #csv comes in as an array
    #     # We turn it to a df for easier manipulation
       
        
    #     # csv.each do |row|
    #     #     puts row.join(", ")
    #     # end
        
    #     df = Pandas.DataFrame(csv.itself[1..-1], columns=csv.itself[0])
    #     puts df.shape

    #     # result = `python3 `
    #     #     puts row
    #     # end 
    #     # puts df.describe
    #     return 1 #Pandas.read_csv(csv)
    # end



end
