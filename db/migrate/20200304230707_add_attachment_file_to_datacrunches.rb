class AddAttachmentFileToDatacrunches < ActiveRecord::Migration
  def self.up
    change_table :datacrunches do |t|
      t.attachment :file
    end
  end

  def self.down
    remove_attachment :datacrunches, :file
  end
end
