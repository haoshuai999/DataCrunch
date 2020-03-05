class RemoveFileFileSizeFromDatacrunches < ActiveRecord::Migration
  def change
    remove_column :datacrunches, :file_file_size, :integer
  end
end
