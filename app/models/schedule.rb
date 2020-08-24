class Schedule < ApplicationRecord
  belongs_to :user
  validates :training_date, presence: true, uniqueness: { scope: :user }
  validates :part, presence: true, inclusion: {in: %w(二の腕 お腹 胸 足) }
  validates :work, presence: true, inclusion: {in: %w(早番 遅番 休み) }
  validates :shape, presence: true, inclusion: {in: %w(良い 不調) }
end
