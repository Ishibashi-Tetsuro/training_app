FactoryBot.define do
  image_path = Rails.root.join("app/assets/images/default.png")

  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password { 'Abcdefg1' }
    image { File.open(image_path) }
  end
end
