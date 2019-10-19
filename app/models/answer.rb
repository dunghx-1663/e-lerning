class Answer < ApplicationRecord
  belongs_to :word
  has_many :results, dependent: :destroy

  # validates :content, presence: true
  scope :correct_answer, ->{where correct: true}
end

