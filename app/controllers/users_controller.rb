class UsersController < ApplicationController
  
  def show
    @user = User.find(params[:id])
  end
  
  def new
    if @user.any?
      @user=@user
    else 
      @user=User.new
    end
  end

  def create 
    @user = User.new(user_params) 
    if @user.save
      flash[:success] = "Welcome to microBlog!"
      redirect_to @user
    else
      render "new"
    end
  end
    
  private
    
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
