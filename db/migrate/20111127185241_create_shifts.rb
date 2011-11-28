class CreateShifts < ActiveRecord::Migration
  def change
    create_table :shifts do |t|
      t.integer :pay_sheet_id
      t.date :date
      t.string :shift
      t.decimal :hours

      t.timestamps
    end
    add_index :shifts, [:pay_sheet_id, :date], :unique => true
  end
end
