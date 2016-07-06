require 'open-uri'
require 'phantomjs'

class CampaignsController < ApplicationController
	before_action :authenticate_user!, :only => [:campaign_creation, :create]

	def campaign_creation
		@campaign = Campaign.new
	end

	def create
		@campaign = Campaign.new(campaign_params)
		@campaign.ownership = current_user.id
		@campaign.save

		Phantomjs.run('./public/javascripts/test.js')
		
		# dealing with cover image
		##upload_path = Rails.root.join("app","assets","images","cover_images")
		##image_name =  params[:campaign][:cover_image].original_filename
		##File.open(upload_path + image_name, 'wb') do |f|
		##	f.write(params[:campaign][:cover_image].read)
		##end
		#this is stupid notation, should be changed, but for some reason adding the strings kept adding an unnecessary "/" and broke the thing
		##File.rename(upload_path.join(image_name), upload_path + "#{Campaign.find_by_title(params[:campaign][:title]).id.to_s}#{File.extname(image_name)}")

		redirect_to "/c/#{@campaign.id}"
	end

	def edit
		@campaign = Campaign.find(params[:id])
	end

	def update
		@campaign = Campaign.find(params[:id])

    	respond_to do |format|
    		if @campaign.update(campaign_params)
      		format.html { redirect_to(@campaign, :action => 'show' , :notice => 'Address was successfully updated.') }
      		format.js
    	end
    end
	end

	def show
		@campaign = Campaign.find(params[:id])
		@campaign.views += 1
		@current_bitcoin_price = JSON.parse(open('https://api.coindesk.com/v1/bpi/currentprice.json').read)['bpi']['USD']['rate'].to_f.round(2)
		@total_deposit = JSON.parse(open("https://blockchain.info/address/#{@campaign.qr_code}?format=json").read)['total_received']
		@account_value = JSON.parse(open("https://blockchain.info/address/#{@campaign.qr_code}?format=json").read)['final_balance']
		@tx_count = JSON.parse(open("https://blockchain.info/address/#{@campaign.qr_code}?format=json").read)['n_tx']
		@total_btc = @total_deposit / 100.to_f.round(10)
		@current_balance = @account_value / 100.to_f.round(10)
		@transaction = JSON.parse(open("https://blockchain.info/address/#{@campaign.qr_code}?format=json&limit=10").read)['txs']
		parent_comments = Comment.where(:commentable_id => @campaign.id)
    	child_comments = Comment.where(:commentable_id => parent_comments.map(&:id))
    	@all_comments = parent_comments + child_comments

    	# potentially could make it unique to each session
		@campaign.save
	end

	def index
		@campaigns = Campaign.all
		
	end

	private
		def campaign_params
			#missing: uploaded_qr_code, tags
			#tags to come when dynamically searching for keywords
			params.require(:campaign).permit(:title,:type,:preferred_currency, :category,:qr_code, :goal, :description, :website)
    	end
end