require "test_helper"

class IndexTest < ActionDispatch::IntegrationTest
  
  def setup
    @admin      = users(:testuser)
    @non_admin  = users(:duckuser)
  end


  
  test "index including pagination" do
    get users_path
    assert_redirected_to login_url
    log_in_as(@non_admin)
    get users_path
    assert_template 'users/index'
    assert_select 'div.pagination'
    assert_select 'button[method=?]', 'delete', count:0
  end

  test "index as admin with delete links" do
    log_in_as(@admin)
    get users_path
    first_page_of_users = User.paginate(page: 1)
    first_page_of_users.each do |user|
      assert_select 'a[href=?]', user_path(user), text: user.name
      unless user == @admin
        assert_select 'button', 'delete'
      end
    end
    assert_difference 'User.count', -1 do
      delete user_path(@non_admin)
    end
  end

end
