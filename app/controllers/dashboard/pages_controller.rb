class Dashboard::PagesController < ApplicationController
  before_action :check_user

  def index
    @card = if current_user.current_pack
              current_user.current_pack.cards.review.first
            else
              current_user.cards.review.first
            end
    respond_to do |format|
      format.html { flash.keep }
      format.js
    end
  end

  def check_card
    @card = Card.find(params[:card_id])
    check_result = @card.check_answer(answer_params[:answer])
    if check_result.zero?
      SuperMemo.new(@card).successful(params[:time].to_i)
    elsif check_result == 1
      SuperMemo.new(@card).successful(params[:time].to_i)
      flash[:notice] = "#{t('controllers.mistake')} #{answer_params[:answer]}, #{t('controllers.correct_writing')} #{@card.translated_text}"
    else
      SuperMemo.new(@card).failed
      flash[:notice] = t('controllers.incorrect')
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
