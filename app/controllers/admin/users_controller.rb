class Admin::UsersController < ApplicationController
  before_action :load_user, only: %i(edit update destroy )

  def index
    @q = User.search params[:q]
    @users = @q.result.order_by_email.page(params[:page]).
      per Settings.user_per_page
  end

  def edit; end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = t :create_user_success
      redirect_to admin_users_path
    else
      flash[:danger] = t :create_user_fail
      render :new
    end
  end

  def update
    if @user.update_attributes user_params
      flash[:success] = t :updated_user
      redirect_to admin_users_path
    else
      flash[:danger] = t :update_user_fail
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t :deleted_user
    else
      flash[:danger] = t :delete_user_fail
    end
    redirect_to admin_users_path
  end


  private

  def user_params
    params.require(:user).permit :name, :email, :password
  end

  def load_user
    @user = User.find_by id: params[:id]
    return if @user
    flash[:danger] = t :user_not_found
    redirect_to admin_users_path
  end
end
