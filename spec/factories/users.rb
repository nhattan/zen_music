FactoryGirl.define do
  factory :user do
    name { Faker::Name.name }
    email { |i| Faker::Internet.email }
    password  "123123123"
    confirmed_at Time.current
  end
end
