class RemoveFileContentTypeFromDatacrunches < ActiveRecord::Migration
  def change
    remove_column :datacrunches, :file_content_type, :string
  end
end
