class RemoveCreatetimeFromDatacrunches < ActiveRecord::Migration
  def change
    remove_column :datacrunches, :createtime, :datetime
  end
end
