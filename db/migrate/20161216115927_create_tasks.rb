class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :title
      t.text :description
      t.integer :priority
      t.date :due_date
      t.integer  :assign_user_id,null: false
      t.string :status,default:"open"
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
