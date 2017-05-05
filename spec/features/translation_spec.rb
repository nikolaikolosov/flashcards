require 'rails_helper'
require 'support/factory_girl'
require 'support/login_helper'

describe 'Main page test for guest' do
  before(:each) do
    visit root_path
  end

  it 'translates menu to english' do
    click_link 'en'
    expect(page).to have_content 'Main'
  end
  
  it 'translates menu to russian' do
    click_link 'ru'
    expect(page).not_to have_content 'Main'
  end
end


describe 'change user locale' do
  before(:each) do
    user = create(:user)
    login
    visit root_path
    click_link I18n.t('layouts.application.edit_profile')
    fill_in 'user_email', with: '1@1.ru'
    fill_in 'user_password', with: 'password'
    fill_in 'user_password_confirmation', with: 'password'
  end

  it "changes language to english" do
    select 'en', from: 'user_locale'
    click_button I18n.t('shared.save')
    expect(page).to have_content 'Welcome to flashcards manager'
  end

  it "changes language to russian" do
    select 'ru', from: 'user_locale'
    click_button I18n.t('shared.save')
    expect(page).to have_content 'Добро пожаловать в менеджер флеш-карточек'
  end
end