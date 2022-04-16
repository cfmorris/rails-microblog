require "test_helper"

class UsersEditTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:testuser)
  end

  test 'unsuccessful edit' do
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: { user: { name:"", 
                                              email:"foo@blah", 
                                              password:"foo", 
                                              password_confirmation:"bar" } }
    assert_template 'users/edit'
    assert_select 'div[id=?]', 'error_messages', count:1
    assert_select 'p[class=?]', 'error', count: 4
  end

  test 'successful edit' do
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: { user: { name:"user", 
                                              email:"user@test.com", 
                                              password:"password1", 
                                              password_confirmation:"password1" } }
    assert_redirected_to user_path
    follow_redirect!
    assert_select 'div[class=?]', 'text-center alert alert-success', count: 1
    assert_template 'users/show'
  end

  
  
  test "login and edit profile" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template "users/edit"
    assert_select "form[action=?]", user_path, count: 1
    assert_select "input[type=?]", "text", count: 2
    assert_select "input[type=?]", "password", count: 2
    assert_select "input[type=?]", "submit", count: 1

    end
  end