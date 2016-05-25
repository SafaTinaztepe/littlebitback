class Campaign < ActiveRecord::Base
	validates_uniqueness_of :title
  validates_length_of :qr_code, minimum: 26, maximum: 34

  has_many :comments
  belongs_to :user
	
end
