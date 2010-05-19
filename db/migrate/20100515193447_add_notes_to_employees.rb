class AddNotesToEmployees < ActiveRecord::Migration
  def self.up
    add_column :employees, :notes, :text
  end

  def self.down
    remove_column :employees, :notes
  end
end
