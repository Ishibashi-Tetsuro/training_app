class Exercise < ApplicationRecord

  belongs_to :user

  validates :part, presence: true
  validates :url, presence: true,
                  format: { with: /(\Ahttps\:\/\/)?(www\.)?(youtube\.com\/watch\?v=|youtu\.be\/)+[\S]{11}\z/ }
  validates :level, presence: true

end
