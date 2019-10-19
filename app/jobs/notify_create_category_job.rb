class NotifyCreateCategoryJob < ApplicationJob
  queue_as :default

  def perform
    LessonCreateMailer.notify_all_user.deliver
  end
end
