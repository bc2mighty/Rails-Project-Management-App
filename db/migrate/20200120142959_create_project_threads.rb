class CreateProjectThreads < ActiveRecord::Migration[6.0]
  def change
    create_table :project_threads do |t|
      t.string :thread_id
      t.references :project, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.string :topic
      t.text :description

      t.timestamps
    end
  end
end
