require 'rails_helper'
require 'support/factory_girl'
require 'support/login_helper'

describe 'Login to site' do
  before(:each) do
    user = create(:user)
    visit root_path
  end

  it "doesn't opens main page after unsuccessful login" do
    login(password = 'incorrect')
    expect(page).to have_content "Неудачная попытка входа"
  end

  it "opens main page after login" do
    login
    expect(page).not_to have_content "Неудачная попытка входа"
  end

  it "make logout action" do
    login
    click_link 'Выход'
    expect(page).to have_content "Вы успешно вышли"
  end
end


describe 'register new user' do
  before(:each) do
    visit root_path
  end
  it "register new user" do
    click_link 'Регистрация'
    fill_in 'user_email', with: '1@1.ru'
    fill_in 'user_password', with: 'password'
    fill_in 'user_password_confirmation', with: 'password'
    click_button 'Сохранить'

    expect(page).to have_content 'Вход выполнен'
  end
end
