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
		# @paramteres = listing_params[:street_address]	+ listing_params[:city] + listing_params[:state] 
		@pov = {}
		@pov['pano_id'] = listing_params[:pano_id]
		@pov['heading'] = listing_params[:heading]
		@pov['pitch'] = listing_params[:pitch]

		@listing = {}
		@listing['oohm_id'] = listing_params[:oohm_id]
		@listing['oohm_vendor'] = listing_params[:oohm_vendor]


respond_to do |format|
   format.js #-> will just call [action].js.erb
end

	end
	
	private
	
	def set_sandbox_context
		@user = User.find(current_user.id)
	end

	def listing_params
	params.require(:coohration) .permit(:lat, :lng, :pano_id, :heading, :pitch, :oohm_id, :oohm_vendor)
	end
end