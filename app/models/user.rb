class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :name, presence: true
  mount_uploader :image, ImageUploader
  has_many :diaries, dependent: :destroy
  has_many :schedules, dependent: :destroy
  has_many :exercise, dependent: :destroy
  has_one :count, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_diaries, through: :likes, source: :diary

  def already_liked?(diary)
    self.likes.exists?(diary_id: diary.id)
  end

  def self.guest
    find_or_create_by(email: "test@example.com") do |user|
      user.password = 'testtest'
      user.name = 'テストユーザー'
    end
  end

  def update_without_current_password(params, *options)
    params.delete(:current_password)
    params.delete(:password)
    params.delete(:password_confirmation)

    result = update_attributes(params, *options)
    clean_up_passwords
    result
  end
end
