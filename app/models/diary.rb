class Diary < ApplicationRecord

  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user
  mount_uploader :image, ImageUploader

  validates :content, presence: true, length: { maximum: 200 }
  validates :image, presence: { message: 'が添付されていません' }

  private

end
