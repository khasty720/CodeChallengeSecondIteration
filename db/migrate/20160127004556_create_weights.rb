class CreateWeights < ActiveRecord::Migration
  def change
    create_table :weights do |t|
      t.integer :value

      t.timestamps null: false
    end
  end
end
