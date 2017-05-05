def login(email = 'test@test.ru', password = 'test')
  visit root_path
  click_link I18n.t('shared.enter')
  fill_in :email, with: email
  fill_in :password, with: password
  click_button I18n.t('shared.enter')
end