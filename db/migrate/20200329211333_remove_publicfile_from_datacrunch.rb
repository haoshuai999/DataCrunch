class RemovePublicfileFromDatacrunch < ActiveRecord::Migration
  def change
    remove_column :datacrunches, :publicfile, :boolean
  end
end
