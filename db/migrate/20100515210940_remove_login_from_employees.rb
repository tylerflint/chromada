class RemoveLoginFromEmployees < ActiveRecord::Migration
  def self.up
    remove_column :employees, :login
  end

  def self.down
    add_column :employees, :login, :string, :limit => 40
  end
end
