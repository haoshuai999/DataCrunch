class AddDefaultValueToPublicity < ActiveRecord::Migration
  def self.up
    change_column :datacrunches, :publicity, :boolean, :default => true
  end
end
