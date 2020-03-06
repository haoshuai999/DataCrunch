class Datacrunch < ActiveRecord::Base
    has_attached_file :data, :use_timestamp => false
    #validates_attachment_content_type :data, :content_type => [".csv", ".json", ".xlsx"], :message => "content type validation error"
    # validates_with AttachmentContentTypeValidator, attributes: :data, :content_type => ["text/plain", "application/json"]
    do_not_validate_attachment_file_type :data
    Paperclip.options[:content_type_mappings] = {:csv => "text/plain", :json => "text/plain"}
    # # def self.accessRecord

    # end
end
