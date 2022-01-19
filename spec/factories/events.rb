FactoryBot.define do
  factory :event do
    association :user

    title { 'Test' }
    description { 'Something' }
    address { 'Somewhere' }
    datetime { Time.parse('09.01.2022, 12:00') }
  end
end
