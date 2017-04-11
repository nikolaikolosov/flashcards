require 'rails_helper'
require 'support/factory_girl'
require 'support/login_helper'

describe 'Add pack page tests' do
  before(:each) do
    user = create(:user_with_one_pack_without_cards)
    login
    visit packs_path
  end

  it 'show pack' do
    expect(page).to have_content 'Список колод'
    expect(page).to have_content 'Сделать активной'
    expect(page).to have_content 'Удалить'
  end

  it 'edit pack' do
    click_link 'Редактировать'
    expect(page).to have_content 'Редактирование колоды'
    expect(page).to have_content 'Название колоды'
  end

  it 'delete pack' do
    click_link 'Удалить'
    expect(page).not_to have_content 'Сделать активной'
    expect(page).not_to have_content 'Удалить'
  end

  describe 'active/inactive tests' do
    before(:each) do
      click_link 'Сделать активной'
    end

    it 'make pack active' do
      expect(page).to have_content 'Сделать неактивной'
      expect(page).not_to have_content 'Сделать активной'
    end

    it 'make pack inactive' do
      click_link 'Сделать неактивной'
      expect(page).to have_content 'Сделать активной'
      expect(page).not_to have_content 'Сделать неактивной'
    end
  end


end