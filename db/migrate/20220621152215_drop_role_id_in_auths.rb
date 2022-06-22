class DropRoleIdInAuths < ActiveRecord::Migration[7.0]
  def change
    remove_column :auths, :role_id
  end
end
