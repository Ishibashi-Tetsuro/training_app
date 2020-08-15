class Diary < ApplicationRecord

  attr_accessor :remove_image

  before_save :remove_image_if_user_accept

  belongs_to :user
  has_one_attached :image, dependent: false

  private

  def remove_image_if_user_accept
    self.image = nil if ActiveRecord::Type::Boolean.new.cast(remove_image)
  end

end
