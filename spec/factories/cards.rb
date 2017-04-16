FactoryGirl.define do
  factory :card do
    original_text 'Stadt'
    translated_text 'city'
    review_date (Time.now - 10.days)
    pack
  end
end