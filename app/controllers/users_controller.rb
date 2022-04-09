class UsersController < ApplicationController
  
  def show
    @user = User.find(params[:id])
  end
  
  def new
    @user=User.new
  end

  def create 
    @user = User.new(user_params) # not the final implementation
    if @user.save
    else
      render 'new'
    end
  end
    
  priv:after =>  column_name
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
