class Assignment < ActiveRecord::Base
  attr_accessible :content, :deadline, :user_id, :group_id, :finished

  attr_accessible :photo
  has_attached_file :photo, :styles => { :medium => "300x300>", :thumb => "100x100>" }

  belongs_to :group
  belongs_to :user

  after_save :add_assignment
  after_save :update_group

  private

  def add_assignment
    if finished
      group = Group.find(group_id)
      members = group.users

      Rails.logger.info(members)

      assignee = members.order("RANDOM()").first

      task = Task.order("RANDOM()").first
      content = task.content

      task.used = true
      task.save

      Assignment.create(content: content, deadline: 1.hours.from_now - 1.minute, user_id: assignee.id, group_id: group_id, finished: false)
    end
  end

  def update_group
    group = Group.find(group_id)
    group.last_update = DateTime.now
    group.save
  end
end
