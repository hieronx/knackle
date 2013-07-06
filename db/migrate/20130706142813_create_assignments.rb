class CreateAssignments < ActiveRecord::Migration
  def change
    create_table :assignments do |t|
      t.text :content
      t.integer :user_id
      t.datetime :deadline

      t.timestamps
    end
  end
end
