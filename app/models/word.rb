class Word < ApplicationRecord
  belongs_to :category
  has_many :answers, dependent: :destroy
  has_many :results, dependent: :destroy

  accepts_nested_attributes_for :answers, reject_if: :all_blank, allow_destroy: true
  validates :content, presence: true

  scope :alls, ->user_id{}
  scope :learned, ->user_id{where "id IN (SELECT word_id FROM answers WHERE
    correct = '1' AND id IN (SELECT answer_id FROM results WHERE lesson_id IN (SELECT id FROM
      lessons WHERE user_id = #{user_id})))"}
  scope :not_learned, ->user_id{where "id NOT IN (SELECT word_id FROM answers WHERE
    correct = '1' and id IN (SELECT answer_id FROM results WHERE lesson_id IN (SELECT id FROM
      lessons WHERE user_id = #{user_id})))"}
  scope :order_date_desc, ->{order created_at: :desc}
  validate :must_be_a_answer_correct, on: [:create, :update]

  scope :order_by_name, ->{order :content}

  private
  def must_be_a_answer_correct
    unless self.answers.select{|answer| answer.correct}.size == Settings.a_answer_correct
      errors.add " ", I18n.t(:must_have_correct_answer)
    end
  end
end
