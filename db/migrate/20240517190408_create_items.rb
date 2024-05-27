class CreateItems < ActiveRecord::Migration[7.1]
  def change
    create_table :items do |t|
      t.string :name, null: false
      t.references :collection, null: false, foreign_key: true
      t.string :tags
      t.timestamps
    end
  end
end
