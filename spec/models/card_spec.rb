require 'rails_helper'
require 'support/factory_girl'
require 'support/card_helper'
  
RSpec.describe Card, type: :model do
  context 'card' do
    let(:card) { create :card }
    context 'callbacks' do
      it 'get correct review date on create' do
        expect(card.review_date.to_date).to eq(Time.now.to_date)
      end

      it 'get incorrect review date on create' do
        expect(card.review_date.to_date).not_to eq(-1.day.from_now.to_date)
      end

      it 'test check_answer method return 0' do
        check_result = card.check_answer('city')
        expect(check_result).to be 0
      end

      it 'test check_answer method return 1' do
        check_result = card.check_answer('cyty')
        expect(check_result).to be 1
      end

      it 'test check_answer method as false' do
        check_result = card.check_answer('village')
        expect(check_result).to be 6
      end
    end

    context 'service successful checks' do
      it 'first check correct' do
        card_successful(1, 5)
        review_date_helper(2)
      end

      it 'second check correct' do
        card_successful(2, 4)
        review_date_helper(3)
      end

      it 'third check correct' do
        card_successful(3, 3)
        review_date_helper(4)
      end

      it 'fourth check correct' do
        card_successful(4, 2)
        review_date_helper(5)
      end

      it 'fifth check correct' do
        card_successful(5, 1)
        review_date_helper(6)
      end

      it 'sixth check correct' do
        card_successful(6, 4)
        review_date_helper(7)
      end
    end

    context 'service wrong checks' do
    before(:each) do
      card_successful(5, 1)
      review_date_helper(6)
    end

      it 'first check wrong' do
        card_failed(1)
        expect(card.mistake).to eql(1)
        review_date_helper(6)
      end

      it 'second check wrong' do
        card_failed(2)
        expect(card.mistake).to eql(2)
        review_date_helper(6)
      end

      it 'third check wrong' do
        card_failed(3)
        expect(card.mistake).to eql(3)
        review_date_helper(6)
      end

      it 'fourth check wrong - reset parameters' do
        card_failed(4)
      date = Time.now
        expect(card.review_date.to_date).to eql(date.to_date)
        expect(card.level).to eql(0)
        expect(card.mistake).to eql(0)
      end
    end
  end
end
