require 'rails_helper'
require 'support/factory_girl'
  
RSpec.describe Card, type: :model do
  context 'callbacks' do
    let(:card) { create :card }

    it 'get correct review date on create' do
      expect(card.review_date.to_date).to eq(-1.day.from_now.to_date)
    end

    it 'get incorrect review date on create' do
      expect(card.review_date.to_date).not_to eq(Time.now.to_date)
    end

    it 'test check_answer method as true' do
      check_result = card.check_answer('city')
      expect(check_result).to be true
    end

    it 'test check_answer method as false' do
      check_result = card.check_answer('village')
      expect(check_result).to be false
    end
  end
end
