class Group < ActiveRecord::Base
  attr_accessible :title

  has_many :memberships, :dependent => :destroy  
  has_many :users, :through => :memberships

  has_many :assignments
end
