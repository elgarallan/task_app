class TasksController < ApplicationController
  before_action :set_category

  def new
    @task = @category.tasks.build
  end

  def create
    @task = @category.tasks.build(task_params)
    if @task.save
      redirect_to root_path, notice: "Task added successfully!"
    else
      flash.now[:alert] = "There was a problem adding the task."
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @task = @category.tasks.find(params[:id])
  end

  def update
    @task = @category.tasks.find(params[:id])
    if @task.update(task_params)
      redirect_to root_path, notice: "Task updated successfully!"
    else
      flash.now[:alert] = "There was a problem updating the task."
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @task = @category.tasks.find(params[:id])
    @task.destroy
    redirect_to root_path, notice: "Task deleted successfully!"
  end

  private

  def set_category
    @category = Category.find(params[:category_id])
  end

  def task_params
    params.require(:task).permit(:name, :due_date)
  end
end
