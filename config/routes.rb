Rails.application.routes.draw do
  resources :users
  resources :user_sessions, only: [:new, :create, :destroy]
  get 'login' => 'user_sessions#new', as: :login
  post 'logout' => 'user_sessions#destroy', as: :logout

  root 'pages#index'
  resources :packs do
    member do
      put 'set_as_current'
      put 'reset_as_current'
    end
  end

  resources :cards
  put 'check_card' => 'pages#check_card', as: 'check_card'
end
