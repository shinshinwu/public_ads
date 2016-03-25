class InquiriesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :set_inquiry_context, only: [:create]

  def create
    @inquiry = Inquiry.new
    @inquiry.listing_id = @listing.id
    @inquiry.sender_id = @user.id
    @inquiry.recipient_id = @listing.user.id
    @inquiry.start_date = Date.new(params[:inquiry]["start_date(1i)"].to_i, params[:inquiry]["start_date(2i)"].to_i, params[:inquiry]["start_date(3i)"].to_i)
    @inquiry.end_date = Date.new(params[:inquiry]["end_date(1i)"].to_i, params[:inquiry]["end_date(2i)"].to_i, params[:inquiry]["end_date(3i)"].to_i)

    subject = params[:inquiry][:conversation][:subject]
    body = params[:inquiry][:conversation][:body]

    if @inquiry.end_date <= @inquiry.start_date
      flash[:error] = "Sorry, your desired end date is before your desired start date!"
      redirect_to :back and return
    end

    begin
      receipt = @user.send_message(@listing.user, body, "Listing NO.#{@listing.id}: #{subject}")
      @inquiry.conversation_id = receipt.conversation.id
      @inquiry.save!
    rescue => e
      flash[:error] = "#{e.message}"
      redirect_to :back and return
    end
    flash[:success] = "Your inquiry has been sent! The listing owner should get back to you shortly"
    redirect_to listing_path(@listing)
  end

  private

  def set_inquiry_context
    @user = current_user
    @listing = Listing.where(id: params[:inquiry][:listing_id]).first
    if @listing.nil?
      flash[:error] = "Sorry, the listing you are inquiring is not valid"
      redirect_to :back and return
    end
  end
end