require 'supermemo'
class Card < ApplicationRecord
  mount_uploader :image, ImageUploader
  belongs_to :pack
  belongs_to :user
  validates :original_text, :translated_text, :pack_id, presence: true
  validate :different_text
  before_validation :set_review_date, on: :create
  scope :review, -> { where("review_date <= ?", Time.now).order('RANDOM()')  }
  
  #this method returns Levenshtein distance between user answer and translated text
  def check_answer(answer)
    Levenshtein.distance(trim_downcase(answer), trim_downcase(self.translated_text))
  end

  def set_review_date
    self.review_date = Time.now
  end

  private

  def different_text
    if trim_downcase(original_text) == trim_downcase(translated_text)
      errors.add(:original_text, t('models.different_values'))
    end
  end

  def trim_downcase(str)
    str.mb_chars.downcase.to_s.squeeze(' ').lstrip
  end
end