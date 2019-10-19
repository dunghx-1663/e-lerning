class LessonCreateMailer < ApplicationMailer
  def remind_finish_lesson lesson
    @lesson = lesson
    mail to: lesson.user.email, subject: t(:subject_finish_lesson)
  end

  def send_result_to_user lesson
    @lesson = lesson
    mail to: lesson.user.email, subject: t(:subject_result_lesson)
  end

  def notify_all_user
    mail to: User.pluck(:email), subject: t(:subject_create_category)
  end
end
