class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.string :task_title
      t.string :description
      t.integer :status
      t.integer :user_id

      t.timestamps
    end
  end
end
