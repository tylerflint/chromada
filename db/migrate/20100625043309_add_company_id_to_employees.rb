class AddCompanyIdToEmployees < ActiveRecord::Migration
  def self.up
    add_column :employees, :company_id, :int, :after => :id
  end

  def self.down
    remove_column :employees, :company_id
  end
end
