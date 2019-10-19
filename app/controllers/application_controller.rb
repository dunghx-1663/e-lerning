class ApplicationController < ActionController::Base
  protected

  def after_sign_in_path_for resource
    if current_user.admin?
      admin_root_path
    elsif current_user.user?
      root_path
    end
  end
end
