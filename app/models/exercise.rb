class Exercise < ApplicationRecord
  has_many :schedules
  belongs_to :user
end
