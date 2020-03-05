class RemoveDatatypeFromDatacrunches < ActiveRecord::Migration
  def change
    remove_column :datacrunches, :datatype, :string
  end
end
