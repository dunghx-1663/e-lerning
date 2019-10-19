class RelationshipsController < ApplicationController
  before_action :authenticate_user!
  def create
    @user = User.find_by id: params[:followed_id]
    current_user.follow @user
    target_id = @user.name
    Activity.create(content: :follow, target_id: target_id ,user_id: current_user.id)
    redirect_to @user
  end

  def destroy
    @user = Relationship.find_by(id: params[:id]).followed
    current_user.unfollow @user
    target_id = @user.name
    Activity.create(content: :unfollow, target_id: target_id, user_id: current_user.id)
    redirect_to @user
  end

end
