class PagesController < ApplicationController
  def index
    @card = Card.review.first
  end

  def check_card
    @card = Card.find(params[:card_id])
    check_result = @card.check_answer(answer_params[:answer], answer_params[:translated_text])
    if check_result
      @card.review_date = 3.days.from_now
      @card.save
    else
      flash[:notice] = 'Incorrect'
    end
    redirect_to root_path
  end

  private
  
  def answer_params
    params.permit(:answer, :translated_text)
  end
end