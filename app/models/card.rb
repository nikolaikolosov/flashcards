class Card < ApplicationRecord
  mount_uploader :image, ImageUploader
  belongs_to :pack
  belongs_to :user
  validates :original_text, :translated_text, :pack_id, presence: true
  validate :different_text
  before_validation :set_review_date, on: :create
  scope :review, -> { where("review_date <= ?", Time.now).order('RANDOM()')  }
  
  def check_answer(answer)
    trim_downcase(answer) == trim_downcase(self.translated_text)
  end

  def update_review_date
    update(review_date: 3.days.from_now)
  end

  private

  def set_review_date
    #self.review_date = 3.days.from_now
    self.review_date = -1.day.from_now
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