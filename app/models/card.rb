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

  def successful
    increment(:level, 1)
    h = { 2 => 12.hours, 3 => 3.days, 4 => 7.days, 5 => 14.days, 6 => 1.month }
    h.default_proc = proc { |lvl, time| lvl[time] = 1.month }
    update(updated_at: Time.now, review_date: h[level].from_now)
  end

  def failed
    increment(:mistake, 1)
    if mistake == 3
      update(level: 2, mistake: 0)
    else
      update(updated_at: Time.now)
    end
  end

  private

  def set_review_date
    self.review_date = Time.now
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