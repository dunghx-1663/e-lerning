class Admin::CategoriesController < ApplicationController
  before_action :find_category, only: %i(update edit destroy)

  def index
    @q = Category.search(params[:q])
    @categories = @q.result.order_date_desc.page(params[:page])
      .per Settings.cate_per_page
  end

  def new
    @category = Category.new
  end

  def create
    service = CreateCategoryService.new
    result = service.create_category category_params
    if result.success?
      flash[:success] = t :create_cate_succ
      redirect_to admin_categories_path
    else
      @category = result.category
      flash[:danger] = t :create_cate_fail
      render :new
    end
  end

  def update
    if @category.update_attributes category_params
      flash[:success] = t :update_cate_succ
      redirect_to admin_categories_path
    else
      flash[:daner] =  t :update_cate_fail
      render :edit
    end
  end

  def destroy
    begin
      @category.destroy
      flash[:success] = t :delete_cate
    rescue ActiveRecord::DeleteRestrictionError => e
      @category.errors.add(:base, e)
      flash[:flash] = t :delete_cate_fail
    ensure
      redirect_to admin_categories_path
    end
  end

  private

  def category_params
    params.require(:category).permit :name, :description
  end

  def find_category
    @category = Category.find_by id: params[:id]
    return if @category
    flash[:danger] = t :not_found
    redirect_to admin_root_path
  end
end
