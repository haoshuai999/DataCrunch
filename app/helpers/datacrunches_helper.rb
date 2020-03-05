module DatacrunchesHelper
    require 'csv'
    
    
    
    def display_file(datacrunch)
        # puts datacrunch.data.methods
        path = File.join Rails.root, 'public'
        
        data_array = []
        csv_version = CSV.read(File.join(path,datacrunch.data.url))
        # File.open(File.join(path,datacrunch.data.url)) do |fi|
        #     begin
        #         0.times {fi.readline}
        #         1000.times.each{ data_array += CSV.parse(fi.readline)}
        #     rescue EOFError
        #     end
        # end

        return csv_version.take(4)
    end
end
