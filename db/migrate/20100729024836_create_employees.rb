class CreateEmployees < ActiveRecord::Migration
  def self.up
    create_table :employees do |t|
      t.string  :firstname
      t.string  :lastname
      t.string  :employee_number
      t.integer :is_active
      t.text    :notes

      t.timestamps
    end
    
    add_index :employees, :firstname
    add_index :employees, :lastname
    add_index :employees, :employee_number
    add_index :employees, :is_active
  end

  def self.down
    drop_table :employees
  end
end
