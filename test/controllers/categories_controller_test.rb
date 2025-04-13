require "test_helper"

class CategoriesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:one)
    @category = categories(:one)
    sign_in @user
  end

  test "should get index" do
    get root_url
    assert_response :success
    assert_select "h2", "Organize your life."
  end

  test "should get new" do
    get new_category_url
    assert_response :success
  end

  test "should create category" do
    assert_difference("Category.count") do
      post categories_url, params: { category: { title: "New Category" } }
    end

    assert_redirected_to root_path
    follow_redirect!
    assert_match "Category created successfully", response.body
  end

  test "should get edit" do
    get edit_category_url(@category)
    assert_response :success
  end

  test "should update category" do
    patch category_url(@category), params: { category: { title: "Updated Title" } }
    assert_redirected_to root_path
    follow_redirect!
    assert_match "Category updated successfully", response.body
    @category.reload
    assert_equal "Updated Title", @category.title
  end

  test "should destroy category" do
    assert_difference("Category.count", -1) do
      delete category_url(@category)
    end

    assert_redirected_to root_path
    follow_redirect!
    assert_match "Category deleted successfully", response.body
  end

  test "should not allow access to another user's category" do
    other_user = users(:two)
    other_category = categories(:two)
    sign_in other_user

    get edit_category_url(@category)

    assert_redirected_to root_path
    follow_redirect!
    assert_match "Category not found", response.body
  end
end
