class AddCollectionToDynamicFields < ActiveRecord::Migration[7.1]
  def change
    add_reference :dynamic_fields, :collection, :index => true
  end
end
