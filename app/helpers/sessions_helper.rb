module SessionsHelper
  #logs in the given user
  def log_in(user)
    session[:user_id] = user.id
  end

  def remember(user)
    user.remember
    cookies.permanent.encrypted[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end
  
  # Returns the user corresponding to the remember token cookie.
  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.encrypted[:user_id])
      user = User.find_by(id: user_id)

      if user && user&.authenticated?(:remember, cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end

  # Checks if the current @user is logged in (checks both persistent cookies and sessions).
  def logged_in?
    !current_user.nil?
  end

  # Deletes a user's locally stored authorization cookies.
  def forget(user)
    cookies.delete :user_id
    cookies.delete :remember_token
    user.forget if !current_user.nil?
  end
  
  # Terminates session based authentication.
  def log_out
    forget(current_user) 
    session.delete(:user_id)
  end

  # Redirects to a stored location (after authorization)
  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end

  # Stores an unauthorized URL for forwarding after successful login 
  def store_location
    session[:forwarding_url] = request.original_url if request.get?
  end
end

