class UsersController < ApplicationController
  
  def show
    @user = User.find(params[:id])
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
      render 'new', status: :unprocessable_entity, object: @error_messages
    end
  end

  def edit
    @user = current_user
  end
  
  def update
    @user = current_user
    helpers.edit_profile(@user)
    redirect_to edit_user_path(@user)
  end
    
  private
    
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
    
    def update_user_params
      edit_params.require(:user).permit(:new_name, :new_email, :current_password, :new_password, :confirm_new_password)
    end
end
