require 'rails_helper'
require 'support/factory_girl'
require 'support/login_helper'

describe 'Add card page tests' do
  before(:each) do
    user = create(:user_with_one_pack_without_cards)
    login
    visit new_card_path
  end

  it 'save card without image' do
    fill_in 'card_original_text', with: 'Flughafen'
    fill_in 'card_translated_text', with: 'Airport'
    select 'Pack', from: 'card_pack_id'
    click_button 'Сохранить'
    expect(page).to have_content 'Flughafen'
    expect(page).to have_content 'Airport'
    expect(page).to have_content 'Нет изображения'
  end

  it 'save card with image' do
    fill_in 'card_original_text', with: 'Fahrrad'
    fill_in 'card_translated_text', with: 'Bicycle'
    attach_file('card_image', Rails.root + 'spec/fixtures/image.jpg')
    select 'Pack', from: 'card_pack_id'
    click_button 'Сохранить'
    expect(page).to have_content 'Fahrrad'
    expect(page).to have_content 'Bicycle'
    expect(page).to have_css("img[src*='image.jpg']")
  end
end