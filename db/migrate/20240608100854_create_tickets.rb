class CreateTickets < ActiveRecord::Migration[7.1]
  def change
    create_table :tickets do |t|
      t.string :summary
      t.string :priority
      t.string :status
      t.references :user, null: false, foreign_key: true
      t.string :jira_key
      t.string :collection
      t.string :link

      t.timestamps
    end
  end
end
