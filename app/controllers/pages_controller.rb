class PagesController < ApplicationController

  def index
    if current_user == nil
    elsif params[:id]
      @card = current_user.cards.find(params[:id])
    else
      if current_user.current_pack
        @card = current_user.current_pack.cards.review.first
      else
        @card = current_user.cards.review.first
      end
    end
  end


  def check_card
    @card = Card.find(params[:card_id])
    check_result = @card.check_answer(answer_params[:answer])
    if check_result
      @card.update_review_date
    else
      flash[:notice] = 'Incorrect'
    end
    redirect_to root_path
  end

  private

  def answer_params
    params.permit(:answer)
  end
end