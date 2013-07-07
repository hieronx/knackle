class Assignment < ActiveRecord::Base
  attr_accessible :content, :deadline, :user_id, :group_id, :finished

  attr_accessible :photo
  has_attached_file :photo, :styles => { :medium => "300x300>", :thumb => "100x100>" }

  belongs_to :group
  belongs_to :user

  after_save :add_assignment

  private

  def add_assignment
    if finished
      group = Group.find(group_id)
      members = group.users

      assignee = members.first(offset: user_id+1)
      if (assignee.nil?)
        assignee = members.first
      end

      offset = rand(Task.where(used: false).count)
      task = Task.first(offset: offset)
      content = task.content

      task.used = true
      task.save

      Assignment.create(content: content, deadline: 12.hours.from_now - 1.minute, user_id: assignee.id, group_id: group_id, finished: false)
    end
  end
end
