require 'test_helper'

class CategoriesControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user =  User.create(username: "john", email: "john@gmail.com", password: "password", admin: true)
    @category = Category.create(name: "sports", user_id: @user.id)
  end

  test "should get categories index" do
    get categories_path
    assert_response :success
  end

  test "should get new" do
    sign_in_as(@user, "password")
    session[:user_id] = @user.id #simulate login user who is john
    get new_category_path
    assert_response :success
  end

  test "should get show" do
    get '/categories/', params: { id: @category }
    assert_response :success
  end

  test "should redirect create when admin not logged_in" do
    assert_no_difference 'Category.count' do
      post categories_path, params: { category: { name: "sports", user_id: @user.id } } # post to /categories => create 
    end
    assert_redirected_to categories_path
  end

end