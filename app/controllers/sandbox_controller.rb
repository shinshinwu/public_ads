class SandboxController < ApplicationController
  before_filter :authenticate_user!, only: [:new, :get_map]
  before_filter :set_sandbox_context, only: [:new, :get_map]


	def sample
	end

	def new
		@user = User.find(current_user.id)
	end
		
	def get_map
		puts "hello params:" + params.inspect
		@pov = {}
		@pov['pano_id'] = listing_params[:pano_id]
		@pov['heading'] = listing_params[:heading]
		@pov['pitch'] = listing_params[:pitch]

		@listing = {}
		@listing['oohm_id'] = listing_params[:oohm_id]
		@listing['oohm_vendor'] = listing_params[:oohm_vendor]

	redirect_to listings_path










	end
	
	private
	
	def set_sandbox_context
		@user = User.find(current_user.id)
	end

	def listing_params
	params.require(:coohration) .permit(:lat, :lng, :pano_id, :heading, :pitch, :oohm_id, :oohm_vendor, :public_ad_category, :picture)
	end

	# def set_listing_params

	# end
end