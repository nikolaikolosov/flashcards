class PagesController < ApplicationController
  before_action :check_user

  def index
    @card = if current_user.current_pack
              current_user.current_pack.cards.review.first
            else
              current_user.cards.review.first
            end
  end

  def check_card
    @card = Card.find(params[:card_id])
    check_result = @card.check_answer(answer_params[:answer])
    if check_result.zero?
      @card.successful
    elsif check_result == 1
      @card.successful
      flash[:notice] = "Верно, но с опечаткой. Вы ввели #{answer_params[:answer]}, правильное написание #{@card.translated_text}"
    else
      @card.failed
      flash[:notice] = 'Неверно'
    end
    redirect_to root_path
  end

  private

  def check_user
    redirect_to login_path unless current_user
  end

  def answer_params
    params.permit(:answer)
  end
end
