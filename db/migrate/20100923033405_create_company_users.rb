class CreateCompanyUsers < ActiveRecord::Migration
  def self.up
    create_table :company_users do |t|
      t.integer :company_id
      t.integer :user_id
      t.integer :is_owner

      t.timestamps
    end
    
    add_index :company_users, :company_id
    add_index :company_users, :user_id
  end

  def self.down
    drop_table :company_users
  end
end
