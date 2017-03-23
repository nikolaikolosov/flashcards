class Card < ApplicationRecord
  validates :original_text, :translated_text, presence: true
  validate :different_text
  before_validation :set_review_date, on: :create
  
  private

  def set_review_date
    self.review_date = 3.days.from_now
  end

  def different_text
    if trim_downcase(original_text) == trim_downcase(translated_text)
      errors.add(:original_text, 'Вводимые значения должны отличаться.')
    end
  end

    def trim_downcase(str)
    str.mb_chars.downcase.to_s.squeeze(' ').lstrip
  end

end
