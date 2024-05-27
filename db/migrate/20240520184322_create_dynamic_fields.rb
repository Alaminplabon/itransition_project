class CreateDynamicFields < ActiveRecord::Migration[7.1]
  def change
    create_table :dynamic_fields do |t|
      t.string :name
      t.string :field_type

      t.timestamps
    end
  end
end
