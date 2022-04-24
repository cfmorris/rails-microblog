class PasswordResetsController < ApplicationController
  before_action :get_user,          only: [:edit, :update]  # finds the appropriate user for a reset token(which acts as the user_id)
  before_action :valid_user,        only: [:edit, :update]  # ensures the returned is !nil, is authenticated and is activated
  before_action :check_expiration,  only: [:edit, :update]  # ensures the reset token is not expired


  def new
  end
  
  def create
    @user = User.find_by(email: params[:password_reset][:email].downcase)
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = "Email sent with password reset instructions."
      redirect_to root_url
    else
      flash.now[:danger] = "Email address not found"
      render 'new', status: :unprocessable_entity
    end
  end


  def edit
  end

  def update
    if params[:user][:password].empty?
      @error_messages = ["Password can't be empty"]
      render 'edit', status: :unprocessable_entity
    elsif @user.update(user_params)
      log_in(@user)
      @user.forget(:reset)
      flash[:success] = "Password has been reset."
      redirect_to @user
    else
      @error_messages=@user.errors.full_messages
      render 'edit', status: :unprocessable_entity
    end
  end

  private

    def user_params
      params.require(:user).permit(:password, :password_confirmation)
    end

    def get_user
      @user = User.find_by(email: params[:email])
    end

    def valid_user
      unless (@user && @user.activated? &&
              @user.authenticated?(:reset, params[:id]))
        redirect_to root_url
      end
    end

    def check_expiration
      if @user.password_reset_expired?
        flash[:danger] = 'Password reset has expired.'
        redirect_to new_password_reset_url
      end
    end

end
