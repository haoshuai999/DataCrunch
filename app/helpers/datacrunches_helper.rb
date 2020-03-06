module DatacrunchesHelper
    require 'csv'
    require 'roo'
    require 'json'
    require 'json_converter'
    

    
    
    
    def display_file(datacrunch)
        # puts datacrunch.data.methods
        path = File.join Rails.root, 'public'
        file_path = File.join(path,datacrunch.data.url)
        file_ext = File.extname(datacrunch.data.url).downcase

        case file_ext
        when ".csv"
            data = handle_csv(file_path)
        when ".xlsx", ".xls"
            data = handle_excel(file_path)
        when ".json"
            data = handle_json(file_path)
        end
        
       
        # File.open(File.join(path,datacrunch.data.url)) do |fi|
        #     begin
        #         0.times {fi.readline}
        #         1000.times.each{ data_array += CSV.parse(fi.readline)}
        #     rescue EOFError
        #     end
        # end

        return data
    end


    def handle_csv(file_path)
        data_array = []
        csv = CSV.read(file_path)
        puts csv.class
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
end
