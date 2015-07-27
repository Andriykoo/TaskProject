class CreateShareTasks < ActiveRecord::Migration
  def change
    create_table :share_tasks do |t|

      t.references :tasks, index: true, foreign_key: true
      t.references :users, index:true, foreign_keys:true
      t.timestamps null: false
    end
  end
end
