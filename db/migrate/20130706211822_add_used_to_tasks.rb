class AddUsedToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :used, :boolean
  end
end
