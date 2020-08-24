FactoryBot.define do
  factory :like do
    association :user
    association :diary
  end
end
