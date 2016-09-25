require 'test_helper'

class CreateCategoriesTest < ActionDispatch::IntegrationTest

  def setup
    @user = User.create(username: 'john', email: 'john@example.com', password: 'password', admin: true)
  end

  test "get new category form and create category" do
    sign_in_as(@user, "password")
    get new_category_url
    assert_response :success
    assert_difference 'Category.count', 1 do
      post categories_path, params: { category: { name: "sports", user_id: @user.id } }
    end
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_select "h1","Record of Key Messages to be Given to Caregivers"
    assert_match "sports", response.body
  end

  test "invalid category submission results in failure" do 
    sign_in_as(@user, "password")
    get new_category_url
    assert_select "h1","Create new category"
    assert_no_difference 'Category.count' do
      post categories_path, params: { category: { name: " ", user_id: @user.id }}
    end
    assert_select "h1","Create new category"
    assert_select "h2.panel-title"
    assert_select "div.panel-body"
  end

end