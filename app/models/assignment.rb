class Assignment < ActiveRecord::Base
  attr_accessible :content, :deadline, :user_id, :group_id, :finished

  attr_accessible :photo
  has_attached_file :photo, :styles => { :medium => "300x300>", :thumb => "100x100>" }

  belongs_to :group
  belongs_to :user
end
