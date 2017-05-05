require "rails_helper"

RSpec.describe CardMailer, type: :mailer do
  describe 'pending_cards' do
    let!(:user) { create :user }
    let!(:mail) { described_class.pending_cards_notification(user).deliver_now }
    it 'renders the headers' do
      expect(mail.subject).to eq(I18n.t('mailers.subject'))
      expect(mail.to[0]).to eq(user.email)
      expect(mail.from).to eq(['notifications@example.com'])
    end

    it 'renders the body' do
      expect(mail.body.encoded).to match(I18n.t('card_mailer.pending_cards_notification.message'))
    end
  end
end