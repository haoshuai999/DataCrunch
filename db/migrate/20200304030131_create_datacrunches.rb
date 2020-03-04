class CreateDatacrunches < ActiveRecord::Migration
  def change
    create_table :datacrunches do |t|
      t.string :title
      t.string :username
      t.datetime :createtime
      t.text :description
      t.string :datatye
      t.string :size

      t.timestamps null: false
    end
  end
end
