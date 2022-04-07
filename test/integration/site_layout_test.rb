ENV["RAILS_ENV"] ||= "test"
require_relative "../../config/environment"
require "rails/test_help"
require "minitest/reporters"

Minitest::Reporters.use!
require "test_helper"
include ApplicationHelper

class SiteLayoutTest < ActionDispatch::IntegrationTest
  test "layout links" do
    get root_path 
    assert_template '/'
    assert_select "a[href=?]", root_path, count: 2
    assert_select "title", "microBlog"
    assert_select "a[href=?]", help_path
    get help_path
    assert_select "title", full_title("help")
    get about_path
    assert_select "a[href=?]", about_path
    get about_path
    assert_select "title", full_title("about")
    assert_select "a[href=?]", contact_path
    get contact_path 
    assert_select "title", full_title("contact")
  end
end
