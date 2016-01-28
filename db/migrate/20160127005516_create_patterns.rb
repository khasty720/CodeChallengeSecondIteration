class CreatePatterns < ActiveRecord::Migration
  def change
    create_table :patterns do |t|
      t.string :score_pattern
      t.string :description
      t.references :weight, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
