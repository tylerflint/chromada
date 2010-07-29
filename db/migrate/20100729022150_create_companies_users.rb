class CreateCompaniesUsers < ActiveRecord::Migration
  def self.up
    create_table :companies_users, :id => false do |t|
      t.integer :company_id
      t.integer :user_id
    end

    add_index :companies_users, :company_id    
    add_index :companies_users, :user_id
    
  end

  def self.down
    drop_table :companies_users
  end
end
