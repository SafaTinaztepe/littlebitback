class VisitorsController < ApplicationController
	def index
		@campaigns = Campaign.all
	end
end
