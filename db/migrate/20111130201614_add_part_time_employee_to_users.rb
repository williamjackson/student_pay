class AddPartTimeEmployeeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :part_time_employee, :boolean, :default => true
  end
end
