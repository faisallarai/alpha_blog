require 'test_helper'

class ListCategoriesTest < ActionDispatch::IntegrationTest

  def setup
    @user = User.create(username: "john", email: "john@example.com", password: "password", admin: true)
    @category = Category.create(name: "sports", user_id: @user.id)
    @category2 = Category.create(name: "programming", user_id: @user.id)
  end

  test "should show categories listing" do
    get categories_path
    assert_select "h1","Record of Key Messages to be Given to Caregivers"
    assert_select "a[href=?]", category_path(@category), text: @category.name
    assert_select "a[href=?]", category_path(@category2), text: @category2.name
  end

  test "invalid category submission results in failure" do 
    sign_in_as(@user, "password")
    get new_category_url
    assert_response :success
    assert_no_difference 'Category.count' do
      post categories_path, params: { category: {name: " ", user_id: 1}}
    end
    assert_select "h1","Create new category"
    assert_select "h2.panel-title"
    assert_select "div.panel-body"
  end

end