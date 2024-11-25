FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "テストユーザー#{n}" }
    sequence(:email) { |n| "user_#{n}.example.com" }
    password { '12345678' }
    password_confirmation { '12345678' }
  end
end
