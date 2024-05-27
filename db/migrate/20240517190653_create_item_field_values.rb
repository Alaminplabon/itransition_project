class CreateItemFieldValues < ActiveRecord::Migration[7.1]
  def change
    create_table :item_field_values do |t|
      t.references :item, null: false, foreign_key: true
      t.references :item_field, null: false, foreign_key: true
      t.text :value, null: false
      t.timestamps
    end
  end
end
