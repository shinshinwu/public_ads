class ListingsController < ApplicationController
  before_filter :authenticate_user!, only: [:create, :update, :messages, :new]
  before_filter :set_listing_context, except: [:index, :new, :create, :home]

  def home
    @user = User.new
  end

  def index
    @listings = Listing.includes(:address)
  end

  def new
    @listing = Listing.new
    @address = Address.new
  end

  def edit
    unless @listing.user == @user
      flash[:error] = "Sorry, you do not have authorization to edit this listing"
      redirect_to :back
    end
  end

  def show
  end

  def create
    @listing = Listing.new(user_id: current_user.id)

    begin
      ActiveRecord::Base.transaction do
        set_listing_params
        @listing.save!
        @address = Address.new(listing_id: @listing.id)
        set_address_params
        @address.save!
      end
    rescue => e
      flash[:error] = "#{e.message}"
      redirect_to new_listing_path and return
    end

    flash[:success] = "Your listing is successfully posted!"
    redirect_to listing_path(@listing)
  end

  def update
    if params[:listing][:photo]
      @listing.photo = nil
      @listing.save
    end

    begin
      set_listing_params
      @listing.save!
      set_address_params
      @address.save!
    rescue => e
      flash[:error] = "#{e.message}"
      redirect_to :back and return
    end

    flash[:success] = "Successfully updated listing!"
    redirect_to listing_path(@listing)
  end

  def messages
    @messages = @listing.messages.order(:created_at)
    # make sure the current user is either the sender or recipient of the messages
    unless @messages.pluck(:sender_id).uniq.include?(@user.id) || @messages.pluck(:recipient_id).uniq.include?(@user.id)
      flash[:error] = "Sorry, messages not found"
      redirect_to listing_path(@listing) and return
    end
  end

  def payments
  end

  def new_payment
    @transaction = Transaction.new(listing_id: @listing.id)
  end

  private

  def set_listing_context
    @listing = Listing.where(id: params[:id]).first
    if @listing.nil?
      flash[:error] = "Sorry, listing not found"
      redirect_to listings_path and return
    end
    @address = @listing.address
    @user = current_user
  end

  def set_listing_params
    @listing.title        = params[:listing][:title].titleize
    @listing.category     = params[:listing][:category].titleize
    @listing.description  = params[:listing][:description]
    @listing.company_name = params[:listing][:company_name].titleize
    @listing.phone  = params[:listing][:phone]
    @listing.ref_id = params[:listing][:ref_id]
    @listing.width  = params[:listing][:width].to_i
    @listing.height = params[:listing][:height].to_i
    @listing.base_amount  = params[:listing][:base_amount].to_i
    @listing.recurring_amount = params[:listing][:recurring_amount].to_i
    @listing.charge_frequency = params[:listing][:charge_frequency]
    @listing.min_lease_days   = params[:listing][:min_lease_days]
    @listing.is_available     = params[:listing][:is_available].to_i == 1
    @listing.photo  = params[:listing][:photo]
  end

  def set_address_params
    @address.line_1   = params[:listing][:address][:line_1]
    @address.line_2   = params[:listing][:address][:line_2]
    @address.city     = params[:listing][:address][:city]
    @address.state    = params[:listing][:address][:state]
    @address.zipcode  = params[:listing][:address][:zipcode]
    @address.country  = params[:listing][:address][:country]
  end

end