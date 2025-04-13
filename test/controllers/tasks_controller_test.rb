require "test_helper"

class TasksControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:one)
    sign_in @user

    @category = categories(:one)
    @task = tasks(:one)
  end

  test "should get new" do
    get new_category_task_path(@category)
    assert_response :success
  end

  test "should create task" do
    assert_difference("Task.count") do
      post category_tasks_path(@category), params: {
        task: {
          name: "New Task",
          due_date: Date.today
        }
      }
    end
    assert_redirected_to root_path
    follow_redirect!
    assert_match "Task added successfully!", response.body
  end

  test "should get edit" do
    get edit_category_task_path(@category, @task)
    assert_response :success
  end

  test "should update task" do
    patch category_task_path(@category, @task), params: {
      task: { name: "Updated Task" }
    }
    assert_redirected_to root_path
    follow_redirect!
    assert_match "Task updated successfully!", response.body
    @task.reload
    assert_equal "Updated Task", @task.name
  end

  test "should destroy task" do
    assert_difference("Task.count", -1) do
      delete category_task_path(@category, @task)
    end
    assert_redirected_to root_path
    follow_redirect!
    assert_match "Task deleted successfully!", response.body
  end
end
