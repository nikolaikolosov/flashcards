require 'rails_helper'
require 'support/factory_girl'
require 'support/login_helper'

describe 'Main page tests for guest' do
  #that group fo tests show that main page is avaliable and doesn't contain errors
  before(:each) do
    visit root_path
  end

  it 'load page' do
    expect(page).to have_content 'Добро пожаловать в менеджер флеш-карточек'
  end

  it 'load guest menu' do
    expect(page).to have_content 'Главная'
    expect(page).to have_content 'Регистрация'
    expect(page).to have_content 'Вход'
  end

  it 'not load user menu' do
    expect(page).not_to have_content 'Мои колоды'
    expect(page).not_to have_content 'Добавить колоду'
    expect(page).not_to have_content 'Мои карточки'
    expect(page).not_to have_content 'Добавить карточку'
    expect(page).not_to have_content 'Редактировать профиль'
    expect(page).not_to have_content 'Выход'
  end
end

describe 'Main page tests when user has not pack and cards' do
  before(:each) do
    user = create(:user)
    visit root_path
    login
  end

  it 'load page without check_form' do
    expect(page).to have_content 'Вы выучили все доступные карточки. Приходите позже!'
  end

  it 'user successfully logged in' do
    expect(page).not_to have_content 'Слово на немецком:'
  end
end

describe 'Main page tests when user has pack and card' do
  before(:each) do
    user = create(:user_with_one_pack_and_one_card)
    user.cards.each { |card| card.update_attribute(:review_date, Time.now - 10.days) }
    visit root_path
    login
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