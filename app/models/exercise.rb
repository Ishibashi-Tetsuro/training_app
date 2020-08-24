class Exercise < ApplicationRecord

  belongs_to :user

  validates :part, presence: true, inclusion: {
                  in: %w(二の腕 お腹 胸 足) }
  validates :url, presence: true,
                  format: { with: /\A(https\:\/\/)?(www\.)?(youtube\.com\/watch\?v=|youtu\.be\/)+[\S]{11}\z/,
                  message: "YouTubeのURLでないか入力されたURLが間違っている可能性があります"}
  validates :level, presence: true, inclusion: { in: [1, 2, 3] }

end
