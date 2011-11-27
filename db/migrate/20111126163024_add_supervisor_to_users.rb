class AddSupervisorToUsers < ActiveRecord::Migration
  def change
    add_column :users, :supervisor, :boolean, :default => false
  end
end
