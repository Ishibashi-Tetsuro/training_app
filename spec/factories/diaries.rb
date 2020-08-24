FactoryBot.define do
  image_path = Rails.root.join("app/assets/images/default.png")

  factory :diary do
    content {  'abc' }
    image { File.open(image_path) }
    association :user
  end
end
