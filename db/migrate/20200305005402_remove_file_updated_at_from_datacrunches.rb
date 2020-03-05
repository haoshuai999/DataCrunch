class RemoveFileUpdatedAtFromDatacrunches < ActiveRecord::Migration
  def change
    remove_column :datacrunches, :file_updated_at, :string
  end
end
