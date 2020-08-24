class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :rememberable, :validatable
  validates :name, presence: true, uniqueness: true, length: { maximum: 15 }
  VALID_PASSWORD_REGEX =/\A(?=.*?[a-z])(?=.*?[A-Z])(?=.*?[\d])\w{6,12}\z/
    validates :password, presence: true,
              format: { with: VALID_PASSWORD_REGEX,
              message: "は半角6~12文字英大文字・小文字・数字それぞれ１文字以上含む必要があります"}
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
      user.password = 'Testtest1'
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
