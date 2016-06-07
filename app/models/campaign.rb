class Campaign < ActiveRecord::Base
	validates_uniqueness_of :title
  validates_uniqueness_of :qr_code
  validates_length_of :qr_code, minimum: 26, maximum: 34

  has_many :comments, as: :commentable
  belongs_to :user
	
end
