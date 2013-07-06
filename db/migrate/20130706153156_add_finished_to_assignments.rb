class AddFinishedToAssignments < ActiveRecord::Migration
  def change
    add_column :assignments, :finished, :boolean
  end
end
