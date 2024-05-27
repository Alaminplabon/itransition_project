class AddDynamicFieldToItem < ActiveRecord::Migration[7.1]
  def change
    add_column :items, :dynamic_fields, :json
  end
end
