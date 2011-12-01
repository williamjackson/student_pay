class AddFileToUsers < ActiveRecord::Migration
  def change
    add_column :users, :file, :integer
  end
end
