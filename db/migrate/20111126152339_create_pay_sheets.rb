class CreatePaySheets < ActiveRecord::Migration
  def change
    create_table :pay_sheets do |t|
      t.integer :user_id
      t.integer :supervisor_id
      t.string :name
      t.decimal :rate, :precision => 8, :scale => 2


      t.timestamps
    end
    add_index :pay_sheets, [:user_id, :name], :unique => true
    add_index :pay_sheets, :supervisor_id
  end
end
