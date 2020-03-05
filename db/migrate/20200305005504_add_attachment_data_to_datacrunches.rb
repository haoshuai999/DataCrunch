class AddAttachmentDataToDatacrunches < ActiveRecord::Migration
  def self.up
    change_table :datacrunches do |t|
      t.attachment :data
    end
  end

  def self.down
    remove_attachment :datacrunches, :data
  end
end
