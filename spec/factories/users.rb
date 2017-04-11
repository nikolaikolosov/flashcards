FactoryGirl.define do
  factory :user do
    email 'test@test.ru'
    password 'test'
    password_confirmation { password }

    factory :user_with_one_pack_without_cards do
      after(:create) do |user|
        create(:pack, user: user)
      end
    end

    factory :user_with_one_pack_and_one_card do
      after(:create) do |user|
        create(:pack_with_one_card, user: user)
      end
    end

  end
end
