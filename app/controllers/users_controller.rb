class UsersController < ApplicationController
  before_action :logged_in_user,  only: [:index,:edit, :update, :destroy]
  before_action :correct_user,    only: [:edit, :update]
  before_action :admin_user,      only: [:destroy]

  def index
    @users = User.where(activated: true).paginate(page: params[:page])
  end
  
  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
    redirect_to root_url and return unless @user.activated?
  end
  
  def new
      @user=User.new
  end

  def create 
    @user = User.new(user_params) 
    if @user.save
      UserMailer.account_activation(@user).deliver_now
      flash[:info] = "Please check your email to activate account."
      redirect_to root_url
    else
      render 'new', status: :unprocessable_entity
    end
  end

  def edit
    @user = User.find(session[:user_id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "Profile Updated"
      redirect_to user_path
    else
      @user.reload
      render 'edit', status: :unprocessable_entity
    end
  end

  def destroy
      User.find(params[:id]).destroy
      flash[:success] = "User deleted"
      redirect_to users_url
  end  
  
  private
  
  # Defines parameters for user signup and update forms
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  # Before filters.
  
  # Checks if the current_user is a specific user 
  def correct_user
    user = User.find(params[:id])
    redirect_to root_path if user != current_user  
  end

  # Checks if the current user is an admin.
  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end
end
