class Schedule < ApplicationRecord
  belongs_to :user
  validates :training_date, presence: true, uniqueness: { scope: :user }
  validates :part, presence: true
  validates :work, presence: true
  validates :shape, presence: true
end
