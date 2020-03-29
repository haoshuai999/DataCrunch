class AddPublicityToDatacrunch < ActiveRecord::Migration
  def change
    add_column :datacrunches, :publicity, :boolean
  end
end
