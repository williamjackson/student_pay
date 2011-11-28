class CreatePaySheets < ActiveRecord::Migration
  def change
    create_table :pay_sheets do |t|
      t.integer :pay_period_id
      t.integer :job_id
      t.boolean :approved, :default => false

      t.timestamps
    end
      add_index :pay_sheets, [:pay_period_id, :job_id], :unique => true
      add_index :pay_sheets, :job_id
      add_index :pay_sheets, :pay_period_id
  end
end
