class Dataframe
    
    
    attr_accessor :file_path, :dataframe, :cat, :cont
    
    def initialize(datacrunch)
        
        #Calculate and assign the filepath
        file_ext = File.extname(datacrunch.data.url).downcase.split("?")[0]
        @file_path = Datacrunch.get_datacrunch_path(datacrunch)

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
            csv_json = json_converter.generate_csv(json_file)
            
            csv = CSV.parse(csv_json, headers: true, converters: %i[numeric date], empty_value: nil)
            
            @dataframe = Daru::DataFrame.rows(csv.to_a[1..-1], order: csv.headers) #This assumes first row in the json are the column names
        end

        #Store which variables are continuous and categorical
        @cat = Array.new
        @cont = Array.new
        @dataframe.filter do |vector| 
            if vector.type == :numeric
                @cont.append(vector.name)
            else
                @cat.append(vector.name)
            end
        end

     
    end 

    def nrows
        return @dataframe.nrows
    end 
    def ncols
        return @dataframe.ncols
    end 

    def limit(col, row)
        return @dataframe[0..col-1].first(row)
    end 


    def gen_sdev_grid(col, row)
        limited_df =  @dataframe[0..col-1].first(row)

        stdev_df = Daru::DataFrame.new([], order: limited_df.vectors.to_a, index:(0..limited_df.nrows).to_a)

        limited_df.vectors.to_a.each do |colname|
           
            if limited_df[colname].type == :numeric
                stats_vector = remove_nils(@dataframe[colname]) #Produces either a numeric vector or a vector of all nils
                

                # Daru is a crap library. describe doesn't even work if the column has some nil values
                stats = stats_vector.describe
                stdev = stats[:std]
                mean = stats[:mean]
                # puts colname
                # puts "stddev: " + stdev.to_s
                # puts "mean: " + mean.to_s
                limited_df[colname].each_with_index do |rowval,index| #replace first number with num of rows 
                    # puts "value: " + rowval.to_s
                    begin
                        stddevs_from_the_mean  = ((rowval-mean)/stdev).to_i
                        # raise 'An error has occured.'
                    rescue 
                        stddevs_from_the_mean = 0
                    end
                    # stddevs_from_the_mean  = ((rowval-mean)/stdev).to_i
                    # puts "colname: " + colname
                    # puts "row index: " + index.to_s
                    # puts stddevs_from_the_mean
                    stdev_df[colname][index] = stddevs_from_the_mean
                    # puts index
                end 
        
            else #Fill column rows with 0's  
                stdev_df[colname] = Array.new(limited_df.nrows+1, 0)
            end  
        end 


        return stdev_df
    end

    def describe(colname)
        
        if @dataframe[colname].type == :numeric
            stats_vector = remove_nils(@dataframe[colname]) #remove nils so describe can work properly
            return stats_vector.describe 
        end 
        


        if @dataframe[colname].type != :numeric
            
            stats_vector = remove_nils(@dataframe[colname])
            temp_cat = Daru::Vector.new stats_vector, type: :category
            return temp_cat.describe
        end 
    end

    def remove_nils(column_vector) #This apparently doesn't work if all the values in the vector are nil??? Why would they design the vector like that?
        col_without_nils = column_vector.clone
        col_without_nils.delete_if do |val| #removes nil values from numeric columns so .describe can work properly
            val.nil?
        end 

        return col_without_nils
    end 

end 

