class User < ApplicationRecord
  has_many :packs
  has_many :cards
  belongs_to :current_pack, class_name: 'Pack'
  authenticates_with_sorcery!

  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
  validates :email, uniqueness: true

  def make_active(pack)
    update_attribute(:current_pack_id, pack.id)
  end

  def make_inactive
    update_attribute(:current_pack_id, nil)
  end
end
