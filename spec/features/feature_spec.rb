require 'rails_helper'
require 'support/factory_girl'
require 'support/login_helper'

describe 'Main page tests' do
  before(:each) do
    card = create(:card).update_attribute(:review_date, Time.now - 10.days)
    user = create(:user)
    visit root_path
    correct_login
  end

  it 'not load page without check_form' do
    expect(page).not_to have_content 'Вы выучили все доступные карточки. Приходите позже!'
  end

  it 'user successfully logged in' do
    expect(page).not_to have_content 'Пожалуйста, войдите или зарегистрируйтесь, чтобы продолжить'
  end

  it 'user can see card form' do
    expect(page).to have_content 'Слово на немецком:'
  end

  it 'entered incorrect translation' do
    fill_in 'answer', with: 'village'
    click_button 'Проверить'
    expect(page).to have_content 'Incorrect'
  end

  it 'entered correct translation' do
    fill_in 'answer', with: 'city'
    click_button 'Проверить'
    expect(page).not_to have_content 'Incorrect'
  end
end

