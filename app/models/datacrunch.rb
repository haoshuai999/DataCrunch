class Datacrunch < ActiveRecord::Base
    has_attached_file :data
    #validates_attachment_content_type :data, :content_type => [".csv", ".json", ".xlsx"], :message => "content type validation error"
    # validates_with AttachmentContentTypeValidator, attributes: :data, :content_type => ["text/plain", "application/json"]
    do_not_validate_attachment_file_type :data
    Paperclip.options[:content_type_mappings] = {:csv => "text/plain", :json => "text/plain"}

    def self.process_categorical(dataframe, vector)
        displayed_columns = 10
        counter_obj = Counter.new(vector.to_a).most_common(displayed_columns).to_h
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
end
