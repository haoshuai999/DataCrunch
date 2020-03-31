class Dataframe
    
    
    attr_accessor :file_path, :dataframe
    
    def initialize(datacrunch)
        #Calculating the file path
        path = File.join Rails.root, 'public'
        file_path_with_timestamp = File.join(path,datacrunch.data.url)
        file_ext = File.extname(datacrunch.data.url).downcase.split("?")[0]
        file_path = file_path_with_timestamp.split("?")[0]
        
        #Assigning the filepath
        @file_path = file_path

        case file_ext
        when ".csv"
            #This D
            @dataframe = Daru::DataFrame.read_csv(@file_path, liberal_parsing: true) #liberal parsing gets read of this weird quote parsing issue
        when ".xlsx", ".xls"
            @dataframe = Daru::DataFrame.read_excel(@file_path).call(sheet: 0) #call function tells daru to only read the first sheet
        when ".json"
            #Daru has a native read_json function, but this method gets the info hierachy I think we want
            json_file = JSON.parse(File.open(@file_path).read)
            json_converter = JsonConverter.new
            csv_json = json_converter.generate_csv json_file
            csv = CSV.parse(csv_json)
            @dataframe = Daru::DataFrame.rows(csv[1..-1], order: csv[0]) #This assums first row in the json are the column names
        end

        @dataframe.index

     
    end 

    def nrows
        return @dataframe.nrows
    end 
    def ncols
        return @dataframe.ncols
    end 

    def limit(col, row)
        return @dataframe[0..col+1].first(row+1)
    end 

end 

