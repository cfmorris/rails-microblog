class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update, :index, :show]
  before_action :correct_user, only: [:edit, :update]

  def index
    @users = User.all  
  end
  
  def show
    @user = User.find(session[:user_id])
  end
  
  def new
      @user=User.new
  end

  def create 
    @user = User.new(user_params) 
    if @user.save
      log_in @user
      flash[:success] = "Welcome to microBlog!"
      redirect_to @user
    else
      @error_messages = @user.errors.full_messages
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
      @error_messages = @user.errors.full_messages
      @user = User.find(session[:user_id])
      render 'edit', status: :unprocessable_entity
    end
  end
  
  
  private
  
  # Defines parameters for user signup and update forms
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
  
  # Checks if the a current_user is logged in.
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger]="Please log in."
      redirect_to login_url
    end
  end

  # Checks if the current_user is a specific user 
  def correct_user
    user = User.find(params[:id])
    redirect_to root_path if user != current_user  
  end  
end
