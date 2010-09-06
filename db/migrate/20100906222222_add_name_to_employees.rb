class AddNameToEmployees < ActiveRecord::Migration
  def self.up
    add_column :employees, :name, :string, :after => :company_id
    
    # combine the first and last names into the new columns
    execute <<-SQL
      UPDATE employees
      SET name = CONCAT(firstname, ' ', lastname)
    SQL
    
    add_index :employees, :name
    
    remove_column :employees, :firstname
    remove_column :employees, :lastname
  end

  def self.down
    remove_column :employees, :name
    add_column :employees, :firstname, :string, :after => :company_id
    add_column :employees, :lastname, :string, :after => :company_id
  end
end
