require "test_helper"

class UsersEditTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:testuser)
  end

  test 'unsuccessful edit' do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    name = "Foo Bar"
    email = "foo@bar.com"
    patch user_path(@user), params: { user: { name:name, 
                                              email:email, 
                                              password:"2323", 
                                              password_confirmation:"" } }
    # on password error no data is saved                                
    assert_equal assigns(:user).name, @user.name
    assert_equal assigns(:user).email, @user.email
    assert_equal assigns(:user).password_digest, @user.password_digest 
    assert_select 'div[id=?]', 'error_messages', count:1
    assert_select 'p[class=?]', 'error', count: 2
  end

  test 'successful edit' do
    get edit_user_path(@user)
    log_in_as(@user)
    assert_redirected_to edit_user_path(@user)
    name = "Foo Bar"
    email = "foo@bar.com"
    patch user_path(@user), params: { user: { name:name, 
                                              email:email, 
                                              password:"", 
                                              password_confirmation:"" } }
    assert_redirected_to @user
    follow_redirect!
    assert !flash.empty?
    # on password exclusion data is saved
    assert_not_equal assigns(:user).attributes, @user.attributes
    assert_equal assigns(:user).name, name
    assert_equal assigns(:user).email, email
    assert_select 'div[class=?]', 'text-center alert alert-success', count: 1
    assert_template 'users/show'
  end

  
  
  test "edit profile form" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template "users/edit"
    assert_select "form[action=?]", user_path, count: 1
    assert_select "input[type=?]", "text", count: 2
    assert_select "input[type=?]", "password", count: 2
    assert_select "input[type=?]", "submit", count: 1
  
    end
  end
