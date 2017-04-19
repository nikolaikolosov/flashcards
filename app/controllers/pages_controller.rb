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
    if check_result
      @card.successful
    else
      @card.failed
      flash[:notice] = 'Incorrect'
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