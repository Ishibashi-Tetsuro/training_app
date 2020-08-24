FactoryBot.define do
  factory :exercise do
    part { '二の腕' }
    level { '1' }
    url { 'https://www.youtube.com/watch?v=aaaaaaaaaaa' }
    association :user
  end
end
