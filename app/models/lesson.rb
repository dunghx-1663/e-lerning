class Lesson < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :results, dependent: :destroy
  has_many :words, through: :results
  has_many :answers, through: :results
  accepts_nested_attributes_for :results
  before_create :create_word
  after_create :send_mail
  after_update :send_result
  validate :words_quantity, on: :create

  scope :start_by, ->user_id{where user_id: user_id}
  scope :order_date_desc, ->{order created_at: :desc}
  delegate :name, to: :category, prefix: true
  private

  def create_word
    self.words = category.words.limit(Settings.word_limit).order("RAND()")
  end

  def words_quantity
    if category.words.count <= Settings.word_limit
      errors.add :error, I18n.t(:not_enough_word)
    end
  end

  def send_mail
    NotifyFinishLessonJob.delay(run_at: 20.seconds.from_now).perform_later(self)
  end

  def send_result
    SendResultLessonWorker.perform_async self.id
  end
end
