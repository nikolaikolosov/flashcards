require 'rails_helper'
require 'support/factory_girl'
  
RSpec.describe Card, type: :model do
  context 'validations' do 
    it 'create card with empty original text' do
      card = build(:card, original_text: '')
      expect(card).to be_invalid
    end

    it 'create card with empty translated text' do
      card = build(:card, translated_text: '')
      expect(card).to be_invalid
    end

    it 'create card with same original and translated text' do
      card = build(:card, original_text: 'Stadt', translated_text: 'stadt')
      expect(card).to be_invalid
    end
  end

  context 'callbacks' do   
    it 'get correct review date on create' do
      card = create(:card)
      expect(card.review_date.strftime('%Y-%m-%d %H:%M')).to eq(Time.zone.now.strftime('%Y-%m-%d %H:%M'))
    end
  end
end
