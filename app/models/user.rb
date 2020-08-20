class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :diaries, dependent: :destroy
  has_many :schedules, dependent: :destroy
  has_many :exercise, dependent: :destroy
  has_one :count, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_diaries, through: :likes, source: :diary
  def already_liked?(diary)
    self.likes.exists?(diary_id: diary.id)
  end
end
