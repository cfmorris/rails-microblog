require "test_helper"

class MicropostInterfaceTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:testuser)
  end

  test "micropost interface" do
    log_in_as(@user)
    get root_path
    assert_select 'div.pagination'
    assert_select 'input[type=file]'
    # Invalid submission
    assert_no_difference 'Micropost.count' do
      post microposts_path, params: { micropost: { content: "" } }
    end
    assert_select 'div#error_messages'
    assert_select 'a[href=?]', '/?page=2' #correct pagination link
    # Valid submission
    content = "this micropost is valid, isn't it?"
    image = fixture_file_upload('test/fixtures/kitten.jpg', 'image/jpeg')
    assert_difference 'Micropost.count', 1 do
      post microposts_path, params: { micropost: { content: content, 
                                                   image:   image } }
    end
    assert @user.microposts.first.image.attached?
    # Visit different user (no delete links)
    get user_path(users(:duckuser))
    assert_no_match 'data-confirm="you sure?" type="submit">delete</button>', response.body
  end

  test "micropost siderbar count" do
    log_in_as(@user)
    get root_path
    assert_match "#{@user.microposts.count} microposts", response.body
    # User with zero microposts
    other_user = users(:gooseuser)
    log_in_as(other_user)
    get root_path
    assert_match "0 microposts", response.body
    other_user.microposts.create!(content: "a micropost")
    get root_path
    assert_match "1 micropost", response.body
  end
end
