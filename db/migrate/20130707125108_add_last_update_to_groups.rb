class AddLastUpdateToGroups < ActiveRecord::Migration
  def change
    add_column :groups, :last_update, :datetime
  end
end
