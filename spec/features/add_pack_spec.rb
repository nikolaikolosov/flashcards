require 'rails_helper'
require 'support/factory_girl'
require 'support/login_helper'

describe 'Add pack page tests' do
  before(:each) do
    user = create(:user)
    login
    visit new_pack_path
  end

  it 'save pack' do
    fill_in 'pack_title', with: 'test'
    click_button 'Сохранить'
    expect(page).to have_content 'test'
  end
end