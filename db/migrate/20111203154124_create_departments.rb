class CreateDepartments < ActiveRecord::Migration
  def change
    create_table :departments do |t|
      t.string :name, :unique, :index

      t.timestamps
    end
  end
end
