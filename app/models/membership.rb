class Membership < ActiveRecord::Base
  attr_accessible :group_id, :user_id

  belongs_to :group
  belongs_to :user

  after_save :add_assignment

  def add_assignment
   # if self.users.length >= 2
      Assignment.create(content: "Test", deadline: 12.hours.from_now, user_id: user_id, group_id: group_id, finished: false)
    #end
  end

end