FactoryGirl.define do
  factory :pack do
    title 'Pack'
    user

    factory :pack_with_one_card do
      after(:create) do |pack|
        create(:card, user: pack.user, pack: pack)
      end
    end

  end
end