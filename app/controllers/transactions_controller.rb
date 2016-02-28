class TransactionsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :set_user_context

  def create
    transaction = Transaction.create(
      listing_id: @listing.id,
      seller_id: @listing.user.id,
      buyer_id: @user.id,
      auto_renewal: false
    )

    # then ideally there will be a worker that create recurring transaction and charges them periodically. but for demo, no need

    # create the customer first if we don't have their payment info

    unless @user.customer_id.present?
      token = params[:stripeToken]
      begin
        customer = transaction.create_customer!(user: @user, token: token)
      rescue => e
        flash[:error] = "Sorry, we are having issue charging your card. Please try another payment method."
        redirect_to :back and return
      end
    end

    @user.reload
    # Charge the Customer the base amount instead of the card
    begin
      transaction.charge_customer!(user: @user, listing: @listing)
    rescue => e
      flash[:error] = "Sorry, we are having issue charging your card on file. Please update your payment method."
      redirect_to :back and return
    end

    flash[:success] = "Successfully submitted your payment of $#{@listing.base_amount}!"
    redirect_to :back and return
  end

  private

  def set_user_context
    @user = current_user
    @listing = Listing.where(id: params[:transaction][:listing_id]).first
    if @listing.nil?
      flash[:error] = "Sorry, listing not found"
      redirect_to listings_path and return
    end
  end

end