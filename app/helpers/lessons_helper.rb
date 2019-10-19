module LessonsHelper
  def total_word_in_lesson lesson
    lesson.words.size
  end

  def category_name lesson
    lesson.category_name
  end

end
