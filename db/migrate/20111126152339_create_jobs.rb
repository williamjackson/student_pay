class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.integer :user_id
      t.integer :department_id
      t.string :name
      t.decimal :rate, :precision => 8, :scale => 2


      t.timestamps
    end
    add_index :jobs, [:user_id, :name], :unique => true
    add_index :jobs, :department_id
  end
end
