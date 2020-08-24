class Diary < ApplicationRecord

  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user
  mount_uploader :image, ImageUploader

  validates :content, length: { maximum: 200 }
  validates :content_or_image, presence: true

  private
    def content_or_image
      content.presence or image.presence
    end

end
