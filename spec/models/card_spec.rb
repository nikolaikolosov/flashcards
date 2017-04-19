require 'rails_helper'
require 'support/factory_girl'
  
RSpec.describe Card, type: :model do
  context 'callbacks' do
    let(:card) { create :card }

    it 'get correct review date on create' do
      expect(card.review_date.to_date).to eq(Time.now.to_date)
    end

    it 'get incorrect review date on create' do
      expect(card.review_date.to_date).not_to eq(-1.day.from_now.to_date)
    end

    it 'test check_answer method as true' do
      check_result = card.check_answer('city')
      expect(check_result).to be true
    end

    it 'test check_answer method as false' do
      check_result = card.check_answer('village')
      expect(check_result).to be false
    end

    it 'increase mistake by 1' do
      card.failed
      expect(card.mistake).to be 1
    end

    it 'set level 2 after 3 mistakes' do
      3.times { card.failed }
      expect(card.level).to be 2
    end

    it 'set level 2 successful' do
      card.successful
      expect(card.level).to be 2
      expect(card.review_date.to_date).to eq(12.hours.from_now.to_date)
    end

    it 'set level 3 successful' do
      2.times { card.successful }
      expect(card.level).to be 3
      expect(card.review_date.to_date).to eq(3.days.from_now.to_date)
    end

    it 'set level 4 successful' do
      3.times { card.successful }
      expect(card.level).to be 4
      expect(card.review_date.to_date).to eq(7.days.from_now.to_date)
    end

    it 'set level 5 successful' do
      4.times { card.successful }
      expect(card.level).to be 5
      expect(card.review_date.to_date).to eq(14.days.from_now.to_date)
    end

    it 'set level 6 successful' do
      5.times { card.successful }
      expect(card.level).to be 6
      expect(card.review_date.to_date).to eq(1.month.from_now.to_date)
    end

    it 'set level 99 successful' do
      99.times { card.successful }
      expect(card.level).to be 100
      expect(card.review_date.to_date).to eq(1.month.from_now.to_date)
    end

  end
end
