class AddTagIdToItems < ActiveRecord::Migration[7.1]
  def change
    add_reference :items, :tag, index: true
    remove_column :items, :hash_tag
  end
end
