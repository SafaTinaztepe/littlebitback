class Campaign < ActiveRecord::Base
	validates_uniqueness_of :title
	validates_uniqueness_of :qr_code
	validates_length_of :qr_code, minimum: 26, maximum: 34
	before_save :website_check

	has_many :comments, as: :commentable
	belongs_to :user
	
	protected
		def website_check
        	u = URI(self.website)
        	if (!u.scheme)
            	self.website = "http://#{self.website}"
        end
    end
end
