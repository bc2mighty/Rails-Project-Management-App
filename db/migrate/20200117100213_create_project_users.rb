class CreateProjectUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :project_users do |t|
      t.string :project_user_id
      t.references :project, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.boolean :read_access
      t.boolean :write_access
      t.boolean :update_access
      t.boolean :delete_access

      t.timestamps
    end
  end
end
