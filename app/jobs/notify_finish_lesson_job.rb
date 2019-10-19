class NotifyFinishLessonJob < ApplicationJob
  queue_as :default

  def perform lesson
    LessonCreateMailer.remind_finish_lesson(lesson).deliver unless lesson.learned?
  end
end
