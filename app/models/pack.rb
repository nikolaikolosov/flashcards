class Pack < ApplicationRecord
  has_many :cards, dependent: :destroy
  belongs_to :user
  validates :title, presence: true

  def current?
    id == user.current_pack_id
  end
end
