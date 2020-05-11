class Datacrunch < ActiveRecord::Base
    has_attached_file :data
    #validates_attachment_content_type :data, :content_type => [".csv", ".json", ".xlsx"], :message => "content type validation error"
    # validates_with AttachmentContentTypeValidator, attributes: :data, :content_type => ["text/plain", "application/json"]
    do_not_validate_attachment_file_type :data
    Paperclip.options[:content_type_mappings] = {:csv => "text/plain", :json => "text/plain"}

    def self.process_categorical(dataframe, vector)
        displayed_columns = 10
        counter_obj = Counter.new(vector.to_a).most_common(displayed_columns).to_h
        # puts counter_obj
        if vector.size - vector.count > 0
            counter_obj[:null] = counter_obj.delete nil
            displayed_columns -= 1
        end

        counter_df = Daru::DataFrame.new({:column => counter_obj.keys, :freq => counter_obj.values})
        if Counter.new(vector.to_a).keys.length > displayed_columns
            other_value = dataframe.nrows - counter_df[:freq].sum
            counter_df.add_row(["Other values", other_value])
        end

        return counter_df.to_json

    end

    def self.process_continous(vector)
        return vector.to_df.to_json
    end

    def self.describe_data(dataframe, colname)
        columnvector = dataframe.dataframe[colname]
        
        
        stats_vector = dataframe.describe(colname)
        unique_percent = (columnvector.uniq.size / dataframe.nrows.to_f * 100).round(2).to_s + '%'
        missing_value = columnvector.size - columnvector.count
        missing_percent = (missing_value / columnvector.size.to_f * 100).round(2).to_s + '%'
        stats_vector.concat(unique_percent, :unique_percent)
        stats_vector.concat(missing_value, :missing_value)
        stats_vector.concat(missing_percent, :missing_percent)

        return stats_vector
        
    end

    def self.calc_datacrunch_size(file_size)
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

    def self.get_datacrunch_path(datacrunch)
        path = File.join Rails.root, 'public'
        file_path_with_timestamp = File.join(path,datacrunch.data.url)
        file_path = file_path_with_timestamp.split("?")[0]

        return file_path
    end 
  
    def self.cell_class(value)
        
        case 
        when value == -2 
            set_class = "bottom_two"
        when value <= -3 
            set_class = "bottom_point_one"
        when value == 2  
            set_class = "top_two"
        when value >= 3 
            set_class = "top_point_one"
        when value > -2 && value < 2 
            set_class = 'middle'
        else
            set_class = "null_value"
        end 

        return set_class 
    end 

    # def show_svg(path)
    #     File.open("app/assets/svgs/#{path}", "rb") do |file|
    #         raw file.read
    #     end
    # end 
end
