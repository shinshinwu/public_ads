class SandboxController < ApplicationController
  before_filter :authenticate_user!, only: [:new, :get_map]
  before_filter :set_sandbox_context, only: [:new, :get_map]

	def sample
	end

	def new
		@user = User.find(current_user.id)
	end
		
	def get_map
		@listing = Listing.new(user_id: @user.id)
		begin
			ActiveRecord::Base.transaction do 
				set_listing_params
				@listing.save!
				@address = Address.new(listing_id: @listing.id)
				set_address_params
				@address.save!
				set_address_details
			end
		rescue => e
				flash[:error] = "#{e.message}"
				redirect_to :coohration and return
		end
	flash.now[:success] = "Successfully created new listing"
	redirect_to listing_path(@listing.id)
	end

private
	def set_sandbox_context
		@user = User.find(current_user.id)
	end
	def listing_params
	params.require(:coohration).permit(:lat, :lng, :pano_id, :heading, :pitch, :oohm_id, :oohm_vendor, :public_ad_category, :picture, :title, :description, :zoom)
	end
	def set_listing_params
		@listing.category = listing_params[:public_ad_category]
		@listing.photo = listing_params[:picture]
		@listing.ref_id = listing_params[:oohm_id]
		@listing.company_name = listing_params[:oohm_vendor]
		@listing.title = listing_params[:title]
		@listing.description = listing_params[:description]
	end
	def set_address_params
		@address.latitude  = listing_params[:lat]
		@address.longitude = listing_params[:lng]
	end
	def set_address_details
		set_address_pano_id
		set_address_heading
		set_address_pitch
		set_address_pano_zoom
	end
	def set_address_pano_id
		detail = Detail.new(address_id: @address.id)
		detail.key = 'pano_id'
		detail.value =listing_params[:pano_id]
		detail.save!
	end
	def set_address_heading
		detail = Detail.new(address_id: @address.id)
		detail.key = 'heading'
		detail.value =listing_params[:heading]
		detail.save!
	end
	def set_address_pitch
		detail = Detail.new(address_id: @address.id)
		detail.key = 'pitch'
		detail.value =listing_params[:pitch]
		detail.save!
	end
	def set_address_pano_zoom
		detail = Detail.new(address_id: @address.id)
		detail.key = 'zoom'
		detail.value =listing_params[:zoom]
		detail.save!
	end


end