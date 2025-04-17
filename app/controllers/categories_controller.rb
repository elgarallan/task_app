class CategoriesController < ApplicationController
  before_action :set_category, only: [ :edit, :update, :destroy ]

  def index
    @categories = current_user.categories.includes(:tasks)
    @today_tasks = Task.joins(:category)
                       .where(categories: { user_id: current_user.id })
                       .where(due_date: Date.today)
  end

  def new
    @category = Category.new
  end

  def create
    @category = current_user.categories.build(category_params)
    if @category.save
      redirect_to root_path, notice: "Category created successfully!"
    else
      flash.now[:alert] = "There was a problem creating the category."
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @category = current_user.categories.find_by(id: params[:id])

    if @category.nil?
      redirect_to root_path, alert: "Category not found"
    else
      @tasks = @category.tasks
    end
  end

  def edit; end

  def update
    if @category.update(category_params)
      redirect_to root_path, notice: "Category updated successfully!"
    else
      flash.now[:alert] = "There was a problem updating the category."
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @category.destroy
    redirect_to root_path, notice: "Category deleted successfully!"
  end

private

  def category_params
    params.require(:category).permit(:title)
  end

  def set_category
    @category = current_user.categories.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, alert: "Category not found."
  end
end
