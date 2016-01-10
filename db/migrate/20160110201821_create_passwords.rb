class CreatePasswords < ActiveRecord::Migration
  def change
    create_table :passwords do |t|
      t.string :name
      t.boolean :val_password, default: false

      t.timestamps null: false
    end
  end
end
