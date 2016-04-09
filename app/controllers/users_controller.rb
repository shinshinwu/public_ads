class UsersController < ApplicationController
  before_filter :authenticate_user!, only: [:update]
  before_filter :set_user_context, except: [:new, :create]

  def new
    @user = User.new
  end

  def show
    @listings_to_sell = @user.listings.includes(:address)
    # all the messages the users have received about a listing minues users own listing are the listings the user have inquired about. There is definitely a better way, but for now it's good enough
    @listings_to_buy  = @user.inquired_listings
    @conversations = if @user.mailbox.inbox.present?
      @user.mailbox.inbox
    else
      @user.mailbox.sentbox
    end
  end

  def create
    user_klass = params[:user_type].constantize
    @user = user_klass.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "Welcome to Public Ads!"
    else
      flash[:error] = "Something went wrong!"
    end
    redirect_to coohration_path
  end

  def edit
  end

  def update
    @user.email       = params[:user][:email]
    @user.first_name  = params[:user][:first_name]
    @user.last_name   = params[:user][:last_name]
    @user.phone       = params[:user][:phone]
    if @user.save
      flash[:success] = "Profile Updated!"
    else
      flash[:error] = "Something went wrong when saving your profile"
    end
    redirect_to profile_users_path
  end

  def conversation
    @conversation = Mailboxer::Conversation.where(id: params[:id]).first
    unless @conversation.present? && @conversation.participants.include?(current_user)
      flash[:error] = "Something went wrong loading your messages"
      redirect_to profile_users_path and return
    end

    @messages = @conversation.messages
    @new_message = Mailboxer::Notification.new(conversation_id: @conversation.id)
    inquiry = Inquiry.where(conversation_id: @conversation.id).first
    @listing  = inquiry.listing

    respond_to do |format|
      format.html
      format.js
    end
  end

  def reply
    @conversation = Mailboxer::Conversation.where(id: params[:mailboxer_notification][:conversation_id]).first
    receipt = @user.reply_to_conversation(@conversation, params[:mailboxer_notification][:body])

    respond_to do |format|
      if receipt
        @message = receipt.notification
        format.html { redirect_to profile_users_path, notice: 'Message successfuly send!'}
        format.js {}
        format.json {render json: @message, status: :created, location: @message}
      else
        format.html { redirect_to profile_users_path, notice: 'Sorry, somthing went wrong while sending your reply'}
        format.json { render json: receipt.errors, status: :unprocessable_entity}
      end
    end
  end

  private
  def user_params
    params.require(:user).permit(:email, :password, :user_type)
  end

  def set_user_context
    @user = current_user
  end

end