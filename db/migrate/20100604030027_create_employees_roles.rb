class CreateEmployeesRoles < ActiveRecord::Migration
  def self.up
    create_table :employees_roles, :id => false do |t|
      t.integer :employee_id
      t.integer :role_id
    end
    add_index :employees_roles, :employee_id
    add_index :employees_roles, :role_id
  end

  def self.down
    drop_table :employees_roles
  end
end
