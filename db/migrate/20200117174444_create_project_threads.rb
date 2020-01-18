class CreateProjectThreads < ActiveRecord::Migration[6.0]
  def change
    create_table :project_threads do |t|
      t.string :thread_id
      t.string :project_id
      t.text :topic

      t.timestamps
    end
  end
end
