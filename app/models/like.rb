class Like < ApplicationRecord
  belongs_to :diary
  belongs_to :user
  validates_uniqueness_of :diary_id, scope: :user_id
end
