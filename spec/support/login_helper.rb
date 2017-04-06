def login(email = 'test@test.ru', password = 'test')
  visit root_path
  click_link 'Вход'
  fill_in :email, with: email
  fill_in :password, with: password
  click_button 'Вход'
end