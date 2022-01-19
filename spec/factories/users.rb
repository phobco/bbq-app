FactoryBot.define do
  factory :user do
    name { |n| "User_#{rand(999)}"}
    
    sequence(:email) { |n| "test_#{n}@test.com" }
    after(:build) { |u| u.password_confirmation = u.password = "password"}
  end
end
