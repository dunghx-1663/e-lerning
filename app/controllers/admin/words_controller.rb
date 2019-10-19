class Admin::WordsController < ApplicationController
  before_action :load_word, only: %i(edit update destroy)
  before_action :select_category, except: %i(index destroy)

  def index
    @q = Word.search(params[:q])
    @words = @q.result.order_date_desc.page(params[:page]).per Settings.word_per_page
  end

  def new
    @word = Word.new
  end

  def edit; end

  def create
    @word = Word.new word_params
    if @word.save
      flash[:success] =  t :successfully_created_word
      redirect_to admin_words_path
    else

      flash[:danger] = @word.errors.full_messages.join(", ")
      render :new
    end
  end

  def update
    if @word.update_attributes word_params
      flash[:success] = t :successfully_updated_word
      redirect_to admin_words_path
    else
      flash[:danger] = @word.errors.full_messages.join(", ")
      render :edit
    end
  end

  def destroy
    if @word.destroy
      flash[:success] = t :successfully_destroy_word
    else
      flash[:danger] = t :fail_destroy_word
    end
    redirect_to admin_words_path
  end

  private

  def select_category
    @category = Category.all
  end

  def word_params
    params.require(:word).permit :content, :category_id,
      answers_attributes: [:id, :content, :correct, :_destroy]
  end

  def load_word
    @word = Word.find_by id: params[:id]
    return if @word
    flash[:error] = t :word_not_found
    redirect_to admin_root_path
  end

end
