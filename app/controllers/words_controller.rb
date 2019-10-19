class WordsController < ApplicationController
  def index
    @categories = Category.select(:id, :name)
    if !params[:category_id].nil? && params[:category_id].empty?
      @words = Word.send params[:option], current_user.id
    elsif category = @categories.find_by(id: params[:category_id])
      @words = category.words.send params[:option], current_user.id
    else
      @words = Word.all
    end
    @words = @words.order_by_name.includes(:category, :answers).page(params[:page]).per Settings.word_per_page
  end
end
