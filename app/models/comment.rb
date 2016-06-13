class Comment < ActiveRecord::Base
  acts_as_votable
  belongs_to :user
  belongs_to :campaign
  belongs_to :commentable, polymorphic: true
  has_many :comments, as: :commentable
  
end
