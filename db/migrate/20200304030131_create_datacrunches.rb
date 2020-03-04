class CreateDatacrunches < ActiveRecord::Migration
  def change
    create_table :datacrunches do |t|
      t.string :title
      t.string :username
      t.text :description
      t.string :datatype
      t.string :size

      t.timestamps null: false
    end
  end
end
