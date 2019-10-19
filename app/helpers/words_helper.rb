module WordsHelper
  def correct_answer word
    word.answers.correct_answer.first.content
  end

  def count_correct_answer word
    word.answers.correct_answer.size
  end

end
