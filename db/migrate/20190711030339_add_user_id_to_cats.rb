class AddUserIdToCats < ActiveRecord::Migration[5.2]
  def change
    add_column :cats, :user_id, :integer, null: false
    add_foreign_key :cats, :users, column: :user_id
    add_index :cats, :user_id
    
  end
end
