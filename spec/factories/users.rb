FactoryGirl.define do
  factory :user do
    email 'test@test.ru'
    password 'test'
    password_confirmation { password }
  end
end
