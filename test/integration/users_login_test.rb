require "test_helper"

class UsersLoginTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:testuser)
  end

  test "login with valid email/invalid password" do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: { session: { email:"@1123.com", 
                                         password:"invalid44" } }
    assert_not is_logged_in?
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end

  test "log in with valid information followed by logout" do
    #Initial login
    get login_path
    log_in_as(@user)                                     
    assert is_logged_in?
    assert_redirected_to @user
    follow_redirect!

    correct_navbar?
    delete logout_path
    assert_redirected_to root_url
    
    assert_not is_logged_in?
    delete logout_path
    follow_redirect!
    
    correct_navbar?
    assert_select "a[href=?]", signup_path, count:1
    end


  test "login with invalid information" do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: { session: { email:"", password:"" } }
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end

  test "login with remembering" do
    log_in_as(@user, remember_me:"1")
    assert_equal cookies[:remember_token], assigns(:user).remember_token
  end

  test "login without remembering" do
    log_in_as(@user, remember_me:"1")
    log_in_as(@user, remember_me:"0")
    assert_empty cookies[:remember_token]
  end
  
end
