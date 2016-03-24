class MessagesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :set_message_context, only: [:create]

  def create
    # @message = Message.new
    # @message.listing_id = @listing.id
    # @message.sender_id = @user.id
    # @message.recipient_id = @listing.user.id
    start_date = Date.new(params[:message]["start_date(1i)"].to_i, params[:message]["start_date(2i)"].to_i, params[:message]["start_date(3i)"].to_i)
    end_date = Date.new(params[:message]["end_date(1i)"].to_i, params[:message]["end_date(2i)"].to_i, params[:message]["end_date(3i)"].to_i)
    subject = params[:message][:subject]
    body = params[:message][:body]

    if end_date <= start_date
      flash[:error] = "Sorry, your desired end date is before your desired start date!"
      redirect_to :back and return
    end

    begin
      @user.send_message(@listing.user, body, "Listing NO.#{@listing.id}: #{subject}")
    rescue => e
      flash[:error] = "#{e.message}"
      redirect_to :back and return
    end
    flash[:success] = "Your message has been sent!"
    redirect_to listing_path(@listing)
  end

  private

  def set_message_context
    @user = current_user
    @listing = Listing.where(id: params[:message][:listing_id]).first
    if @listing.nil?
      flash[:error] = "Sorry, the listing you are inquiring is not valid"
      redirect_to :back and return
    end
  end
end