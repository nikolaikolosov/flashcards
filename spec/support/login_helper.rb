def correct_login
  visit root_path
  click_link 'Вход'
  fill_in :email, with: 'test@test.ru'
  fill_in :password, with: 'test'
  click_button 'Вход'
end

def incorrect_login
  visit root_path
  click_link 'Вход'
  fill_in :email, with: 'test@test.ru'
  fill_in :password, with: 'incorrect'
  click_button 'Вход'
end