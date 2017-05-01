class CardMailer < ApplicationMailer
  default from: 'notifications@example.com'
 
  def pending_cards_notification(user)
    if user.email
      mail to: user.email, subject: t('mailers.subject')
    end
  end
end
