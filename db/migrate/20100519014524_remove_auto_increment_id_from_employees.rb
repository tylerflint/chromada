class RemoveAutoIncrementIdFromEmployees < ActiveRecord::Migration
  def self.up
    change_table :employees do |t|
      t.remove  :increment_id
    end
  end

  def self.down
    change_table :employees do |t|
      t.integer :increment_id, :null => true, :after => "id"
    end
  end
end
