class RemoveSizeFromDatacrunches < ActiveRecord::Migration
  def change
    remove_column :datacrunches, :size, :string
  end
end
