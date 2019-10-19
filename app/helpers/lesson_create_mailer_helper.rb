module LessonCreateMailerHelper
  def total_word_in_lesson lesson
    lesson.words.size
  end

  def category_name lesson
    lesson.category_name
  end

  def total_correct_answer word
    word.answers.correct_answer.size
  end
end
