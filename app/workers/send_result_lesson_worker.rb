class SendResultLessonWorker
  include Sidekiq::Worker

  def perform lesson_id
    lesson = Lesson.find_by id: lesson_id
    if lesson.present?
      LessonCreateMailer.send_result_to_user(lesson).deliver
    else
      flash[:warning] = t :not_found
    end
  end
end
