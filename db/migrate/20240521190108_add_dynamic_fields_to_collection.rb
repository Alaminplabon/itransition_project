class AddDynamicFieldsToCollection < ActiveRecord::Migration[7.1]
  def change
    add_column :collections, :dynamic_field, :json
  end
end
