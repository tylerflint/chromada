class ChangeRolesToPermissions < ActiveRecord::Migration
  def self.up
    execute <<-SQL
      RENAME TABLE roles TO permissions;
    SQL
    execute <<-SQL
      RENAME TABLE roles_users TO permissions_users;
    SQL
    execute <<-SQL
      RENAME TABLE actions_roles TO actions_permissions;
    SQL
    execute <<-SQL
      ALTER TABLE actions_permissions CHANGE role_id permission_id int(11) NULL DEFAULT NULL;
    SQL
    execute <<-SQL
      ALTER TABLE permissions_users CHANGE role_id permission_id int(11) NULL DEFAULT NULL;
    SQL
  end

  def self.down
    execute <<-SQL
      RENAME TABLE permissions TO roles;
    SQL
    execute <<-SQL
      RENAME TABLE permissions_users TO roles_users;
    SQL
    execute <<-SQL
      RENAME TABLE actions_permissions TO actions_roles;
    SQL
    execute <<-SQL
      ALTER TABLE actions_roles CHANGE permission_id role_id int(11) NULL DEFAULT NULL;
    SQL
    execute <<-SQL
      ALTER TABLE roles_users CHANGE permission_id role_id int(11) NULL DEFAULT NULL;
    SQL
  end
end
