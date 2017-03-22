class Card < ApplicationRecord
  validates :original_text, :translated_text, presence: true
  before_validation :set_review_date_as_now, on: :create

  private

  def set_review_date_as_now
    self.review_date = Time.now + 3.days
  end
end
