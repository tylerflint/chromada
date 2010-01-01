class RemoveNameFromEmployees < ActiveRecord::Migration
  def self.up
    remove_column :employees, :name
  end

  def self.down
    add_column :employees, :name, :string, :limit => 100, :default => '', :null => true, :after => "login"
  end
end
