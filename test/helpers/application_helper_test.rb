require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  test 'full title helper' do
    assert_equal full_title(""), "microBlog"
    assert_equal full_title("help"), "help | microBlog"
    assert_equal full_title("home"), "home | microBlog"
    assert_equal full_title("about"), "about | microBlog"
    assert_equal full_title("contact"), "contact | microBlog"
  end
end