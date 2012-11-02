FactoryGirl.define do
  sequence(:username) { |i| "vera#{i}" }
  sequence(:email) { |i| "vera#{i}@gemini.com" }

  factory :user do
    username { generate(:username) }
    email { generate(:email) }
    password "password"
  end
end
