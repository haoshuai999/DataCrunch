module DatacrunchesHelper
    # require 'CSV'
    def display_file(datacrunch)
        # test = CSV.read(datacrunch.data)
        
        return datacrunch.data
    end
end
