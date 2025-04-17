require "test_helper"

class CategoryTest < ActiveSupport::TestCase
  setup do
    @user = users(:one)
    @category = categories(:one)
  end

  test "should be valid" do
    assert @category.valid?
  end

  test "title should be present" do
    @category.title = ""
    assert_not @category.valid?
    assert_includes @category.errors[:title], "can't be blank"
  end

  test "user should be present" do
    @category.user = nil
    assert_not @category.valid?
    assert_includes @category.errors[:user], "must exist"
  end

  test "should belong to a user" do
    @category.save
    assert_equal @user, @category.user
  end

  test "should destroy associated tasks when category is destroyed" do
    @category.tasks.destroy_all

    @task = @category.tasks.create!(name: "Test Task")

    assert_difference "Task.count", -1 do
      @category.destroy
    end
  end

  test "can have many tasks" do
    @category.tasks.destroy_all
    task1 = @category.tasks.create!(name: "Task 1")
    task2 = @category.tasks.create!(name: "Task 2")

    assert_equal 2, @category.tasks.size
    assert_includes @category.tasks, task1
    assert_includes @category.tasks, task2
  end
end
