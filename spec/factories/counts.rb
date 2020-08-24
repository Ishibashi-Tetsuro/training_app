FactoryBot.define do
  factory :count do
    day { 1 }
    association :user
  end
end
