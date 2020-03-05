class RemoveFilenameFromDatacrunches < ActiveRecord::Migration
  def change
    remove_column :datacrunches, :filename, :string
  end
end
