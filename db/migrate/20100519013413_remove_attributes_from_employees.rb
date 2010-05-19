class RemoveAttributesFromEmployees < ActiveRecord::Migration
  def self.up
    change_table :employees do |t|
      t.remove  :birthdate
      t.remove  :suffix
      t.remove  :prefix
      t.remove  :middlename
    end
  end

  def self.down
    change_table :employees do |t|
      t.string  :middlename, :limit => 20, :default => '', :null => true, :after => "lastname"
      t.string  :prefix, :limit => 10, :default => '', :null => true, :after => "middlename"
      t.string  :suffix, :limit => 10, :default => '', :null => true, :after => "prefix"
      t.date    :birthdate, :null => true, :after => "suffix"
    end
  end
end
