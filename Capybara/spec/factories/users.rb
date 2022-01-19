FactoryBot.define do
  factory :user do
    username {Faker::Movies::Departed.character}
    password {'password'}
  end
end
