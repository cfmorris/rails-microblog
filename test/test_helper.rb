ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"
require "minitest/reporters"

Minitest::Reporters.use!

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all
  include ApplicationHelper
  # Add more helper methods to be used by all tests here...
  def is_logged_in?
    !session[:user_id].nil?
  end

  def log_in_as(user)
    session[:user_id] = user.id
  end
end

class ActionDispatch::IntegrationTest

  def log_in_as(user, password:'password', remember_me:'1')   #start adding 'sad path' tests to go along with your 'happy me:"1")
    post login_path, params: {session: { email: user.email,
                                        password: password,
                                        remember_me: remember_me} }
  end

  #def update_profile(user={user: {name:"#{user.name}", 
  #                           email:"#{user.email}", 
  #                           password:"#{user.password}", 
  #                           password_confirmation:"#{user.password_confirmation}" } })
  #  patch edit_user_path,
  #end

  def correct_navbar?
    
    assert_select "a[href=?]", root_path
    assert_select "a[href=?]", help_path, count:1
    assert_select "a[href=?]", users_path, count:1
    
    if is_logged_in?
      # True: Home x 2, Users, Help, Profile, Settings, Log out
      # False: Login
      assert_select "a[href=?]", edit_user_path(@user), count:1
      assert_select "form[action=?]", logout_path, count:1 
      assert_select "a[href=?]", login_path, count: 0     
   else
      # True: Home x2, Help, Login
      # False: Logout, Settings, Profile
      assert_select "a[href=?]", login_path, count: 1 
      #assert_select "a[href=?]", edit_user_path(@user), count:0
      assert_select "form[action=?]", logout_path, count:0
   end
  end
end