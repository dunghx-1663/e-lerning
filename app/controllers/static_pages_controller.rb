class StaticPagesController < ApplicationController
  def home
    @lessons = Lesson.order_date_desc.start_by(current_user).includes(:answers, :results).page(params[:page]).per Settings.lesson_per_page
    @activities = Activity.order_date_desc.belongs(current_user)
  end

end
