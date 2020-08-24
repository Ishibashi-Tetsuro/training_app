FactoryBot.define do
  factory :schedule do
    training_date { '2020-01-01' }
    part { '二の腕' }
    work { '早番' }
    shape { '不調' }
    association :user
  end
end
