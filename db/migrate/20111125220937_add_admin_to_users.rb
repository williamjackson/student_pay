class AddAdminToUsers < ActiveRecord::Migration
  def change
    add_column :users, :admins, :boolean, :default => false
  end
end
