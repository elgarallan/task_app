require "test_helper"

class TaskTest < ActiveSupport::TestCase
  setup do
    @user = users(:one)
    @category = categories(:one)
    @task = tasks(:one)
  end

  test "should be valid" do
    assert @task.valid?
  end

  test "name should be present" do
    @task.name = ""
    assert_not @task.valid?
    assert_includes @task.errors[:name], "can't be blank"
  end

  test "category should be present" do
    @task.category = nil
    assert_not @task.valid?
    assert_includes @task.errors[:category], "must exist"
  end

  test "should belong to a category" do
    @task.save
    assert_equal @category, @task.category
  end

  test "should be associated with a user through category" do
    @task.save
    assert_equal @user, @task.category.user
  end

  test "can have a due date" do
    skip unless @task.respond_to?(:due_date)
    tomorrow = Date.tomorrow
    @task.due_date = tomorrow
    @task.save
    assert_equal tomorrow, @task.reload.due_date
  end
end
