class ChangeTagsToItems < ActiveRecord::Migration[7.1]
  def change
    rename_column :items, :tags, :hash_tag
  end
end
