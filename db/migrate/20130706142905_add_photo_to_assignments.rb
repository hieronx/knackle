class AddPhotoToAssignments < ActiveRecord::Migration
  def self.up
    add_attachment :assignments, :photo
  end

  def self.down
    remove_attachment :assignments, :photo
  end
end
