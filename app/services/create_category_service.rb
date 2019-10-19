class CreateCategoryService

  def create_category category_params
    category = Category.new category_params
    if category.save
      send_mail_to_all_users
      Result.new(category, true)
    else
      Result.new(category, false)
    end
  end

  private

  def send_mail_to_all_users
    NotifyCreateCategoryJob.delay(run_at: 10.seconds.from_now).perform_later
  end

  class Result
    attr_reader :category

    def initialize category, success
      @category = category
      @success = success
    end

    def success?
      @success
    end
  end
end
