module CategoriesHelper
  def category_name lesson
    lesson.category.name
  end

  def num_of_word lesson
    lesson.category.words.count
  end
end
