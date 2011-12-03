class AddSupervisorToUsers < ActiveRecord::Migration
  def change
    add_column :users, :supervisor, :boolean, :default => false
    add_column :users, :department_id, :integer
    add_index :users, :supervisor
    add_index :users, :department_id
  end
end
