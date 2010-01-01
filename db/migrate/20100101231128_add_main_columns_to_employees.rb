class AddMainColumnsToEmployees < ActiveRecord::Migration
  def self.up
    change_table :employees do |t|
      t.integer :increment_id, :default => '', :null => true, :after => "id"
      t.string  :employee_id, :limit => 20, :default => '', :null => true, :after => "increment_id"
      t.string  :firstname, :limit => 20, :after => "email"
      t.string  :lastname, :limit => 20, :after => "firstname"
      t.string  :middlename, :limit => 20, :default => '', :null => true, :after => "lastname"
      t.string  :prefix, :limit => 10, :default => '', :null => true, :after => "middlename"
      t.string  :suffix, :limit => 10, :default => '', :null => true, :after => "prefix"
      t.date    :birthdate, :default => '', :null => true, :after => "suffix"
      t.integer :is_active, :default => 1
    end
  end

  def self.down
    change_table :employees do |t|
      t.remove  :is_active
      t.remove  :birthdate
      t.remove  :suffix
      t.remove  :prefix
      t.remove  :middlename
      t.remove  :lastname
      t.remove  :firstname
      t.remove  :employee_id
      t.remove  :increment_id
    end
  end
end
