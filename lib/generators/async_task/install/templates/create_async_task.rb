class CreateAsyncTask < ActiveRecord::Migration
  def change
    create_table :async_tasks do |t|
      t.string :task_name, null: false
      t.string :job_id
      t.integer :perform_after
      t.json :payload
      t.datetime :started_at
      t.datetime :completed_at
      t.string :state, default: :scheduled, null: false
      t.string :external_hash
      t.integer :retry_count, default: 0
      t.timestamps
    end
  end
end
