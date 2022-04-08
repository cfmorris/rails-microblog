require "test_helper"

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get root_path
    assert_response :success
    assert_select "title", "microBlog"
  end

  test "should get help" do
    get help_path
    assert_response :success
    assert_select "title", "help | microBlog"
  end

  test "should get about" do
    get about_path
    assert_response :success
    assert_select "title", "about | microBlog"
  end

  test "should get contact" do
    get contact_path
    assert_response :success
    assert_select "title", "contact | microBlog"
  end

  test "should get signup" do
    get signup_path
    assert_response :success
    assert_select "title", "Sign up! | microBlog"
  end
  test "should get news" do
    get news_path
    assert_response :success
    assert_select "title", "news | microBlog"
  end
end
