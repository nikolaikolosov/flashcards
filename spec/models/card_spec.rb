require 'rails_helper'
require 'support/factory_girl'
  
RSpec.describe Card, type: :model do
  context 'callbacks' do   
    it 'get correct review date on create' do
      card = create(:card)
      expect(card.review_date.to_date).to eq(3.days.from_now.to_date)
    end

    it 'get incorrect review date on create' do
      card = create(:card)
      expect(card.review_date.to_date).not_to eq(Time.now.to_date)
    end

    it 'test check_answer method as true' do
      card = create(:card)
      check_result = card.check_answer('city')
      expect(check_result).to be true
    end

    it 'test check_answer method as false' do
      card = create(:card)
      check_result = card.check_answer('village')
      expect(check_result).to be false
    end
  end
end
