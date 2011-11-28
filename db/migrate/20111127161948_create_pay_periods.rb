class CreatePayPeriods < ActiveRecord::Migration
  def change
    create_table :pay_periods do |t|
      t.date :end_date

      t.timestamps
    end
    add_index :pay_periods, :end_date, :unique => true
  end
end
