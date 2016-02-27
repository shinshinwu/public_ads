class UsersController < ApplicationController
  before_filter :authenticate_user!, only: [:update]
  before_filter :set_user_context, except: [:new, :create]

  def new
    @user = User.new
  end

  def show
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "Welcome to Public Ads!"
    else
      flash[:error] = "Something went wrong!"
    end
    redirect_to profile_users_path
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
      flash[:eroor] = "Something went wrong when saving your profile"
    end
    redirect_to profile_users_path
  end

  private
  def user_params
    params.require(:user).permit(:email, :password)
  end

  def set_user_context
    @user = current_user
  end

end