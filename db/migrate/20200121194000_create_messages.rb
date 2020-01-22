class CreateMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :messages do |t|
      t.string :message_id
      t.references :user, null: false, foreign_key: true
      t.references :project, null: false, foreign_key: true
      t.references :project_thread, null: false, foreign_key: true
      t.text :message

      t.timestamps
    end
  end
end
