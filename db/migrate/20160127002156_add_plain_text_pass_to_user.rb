class AddPlainTextPassToUser < ActiveRecord::Migration
  def change
    add_column :users, :plain_text_pass, :string
  end
end
