class HandleUniqueness < ActiveRecord::Migration[7.1]
  def change
    add_index :collections, :name, unique: true
    remove_column :likes, :user_id, :integer
    add_reference :likes, :user, index: true
  end
end
