require "test_helper"

class UserTest < ActiveSupport::TestCase
  
  def setup
    @user = User.new(name: "Ex ample Us er", email: "user@example.com")
  end
  
  test "should be valid" do
    assert @user.valid?
  end

  test "name should be present" do
    @user.name = "       "
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email= "       "
    assert_not @user.valid?
  end

  test "name should not be too long" do
    @user.name="a"*51
    assert_not @user.valid?
  end
  test "email should not be too long" do
    @user.email = "a" *244 + "@example.com"
    assert_not @user.valid?
  end

  test "email validation should accept valid addresses" do
    valid_addresses = %w[USER@foo.COM THE_US-ER@foo.bar.org first.last@foo.jp alice+bob@fooba.nz]
      valid_addresses.each do |valid_address|
        @user.email = valid_address
        assert @user.valid?, "#{valid_address.inspect} should be valid"
      end
  end
  
  test "email validation should reject addresses" do
  invalid_addresses = %w[user_at_example.com bill@foo,bar user.name@cojp foo@bar_baz.com foo#bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address} should be invalid"  
    end
  end
end