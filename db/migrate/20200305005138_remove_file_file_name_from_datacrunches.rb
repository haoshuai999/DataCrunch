class RemoveFileFileNameFromDatacrunches < ActiveRecord::Migration
  def change
    remove_column :datacrunches, :file_file_name, :string
  end
end
