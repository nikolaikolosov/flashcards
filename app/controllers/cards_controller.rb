class CardsController < ApplicationController
  before_action :set_card, only: [:edit, :update, :destroy]

  def index
    @cards = current_user.cards.order id: :asc
  end

  def new
    @card = Card.new
  end

  def edit
  end

  def create
    @card = current_user.cards.build(card_params)
    if @card.save
      redirect_to cards_path
    else
      render :new
    end
  end

  def update
    if @card.update(card_params)
      redirect_to cards_url
    else
      render :edit
    end
  end

  def destroy
    @card.destroy
    redirect_to cards_url
  end

  private

  def set_card
    @card = Card.find(params[:id])
  end

  def card_params
    params.require(:card).permit(:original_text, :translated_text, :image)
  end
end