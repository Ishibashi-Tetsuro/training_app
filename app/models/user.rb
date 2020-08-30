class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :rememberable, :validatable
  validates :name, presence: true, uniqueness: true, length: { maximum: 15 }
  VALID_PASSWORD_REGEX =/\A(?=.*?[a-z])(?=.*?[A-Z])(?=.*?[\d])\w{6,12}\z/
    validates :password,
              format: { with: VALID_PASSWORD_REGEX,
              message: "パスワードは半角6~12文字英大文字・小文字・数字それぞれ１文字以上含む必要があります"}
  validates_presence_of :password, if: :password_required?
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

  # def update_without_password(params, *options)
  #   params.delete(:current_password)
  #   params.delete(:password)
  #   params.delete(:password_confirmation)
  #   @params = params
  #   result = update_attributes(params, *options)
  #   clean_up_passwords
  #   result
  # end

  def update_without_password(params, *options)
    params.delete(:current_password)

    if params[:password].blank?
        params.delete(:password)
        params.delete(:password_confirmation) if params[:password_confirmation].blank?
    end
    @params = params
    result = update(params, *options)
    clean_up_passwords
    result
  end

  def password_required?
    if @params.nil? || @params.has_key?(:current_password_password) ||@params.has_key?(:password_confirmation) || @params.has_key?(:password)
      true
    else
      false
    end
  end

  # def password_required?
  #   false
  # end
end
