class CreateItemFields < ActiveRecord::Migration[7.1]
  def change
    create_table :item_fields do |t|
      t.references :collection, null: false, foreign_key: true
      t.string :field_name, null: false
      t.string :field_type, null: false
      t.timestamps
    end
  end
end
