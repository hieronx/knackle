class Message < ActiveRecord::Base
  attr_accessible :content, :group_id, :user_id

  belongs_to :group
  belongs_to :user
end
