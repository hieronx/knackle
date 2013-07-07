class Group < ActiveRecord::Base
  attr_accessible :title, :last_update

  has_many :memberships, :dependent => :destroy  
  has_many :users, :through => :memberships

  has_many :assignments

  def add_assignment
   # if self.users.length >= 2
      Assignment.create(content: "Test", deadline: 12.hours.from_now, user_id: self.users.first.id, group: self.id, finished: false)
    #end
  end
end