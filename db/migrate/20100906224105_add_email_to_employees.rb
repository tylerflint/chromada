class AddEmailToEmployees < ActiveRecord::Migration
  def self.up
    add_column :employees, :email, :string, :after => :employee_number
  end

  def self.down
    remove_column :employees, :email
  end
end
