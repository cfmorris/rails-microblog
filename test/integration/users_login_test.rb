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
    get login_path
    log_in_as(@user)                                     
    assert is_logged_in?
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", user_path(@user)
    get logout_path
    assert_redirected_to root_url
    assert_not is_logged_in?
    get logout_path
    follow_redirect!
    assert_select "a[href=?]", logout_path, count: 0
    assert_select "a[href=?]", user_path(@user), count: 0
    assert_select "a[href=?]", login_path
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
    # fix this test - assert_equal @user.cookies.[:remember_token], assigns(:user)[:remember_token]
    
  end

  test "login without remembering" do
    log_in_as(@user, remember_me:"1")
    log_in_as(@user, remember_me:"0")
    assert_empty cookies[:remember_token]
  end
end
