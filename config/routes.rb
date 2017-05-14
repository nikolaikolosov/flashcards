Rails.application.routes.draw do
  root 'dashboard/pages#index'
  put 'check_card' => 'dashboard/pages#check_card', as: 'check_card'
  get 'registration', to: 'users#new'
  get 'login', to: 'home/user_sessions#new'
  post 'login', to: 'home/user_sessions#create'
  post 'logout', to: 'home/user_sessions#destroy'

  scope module: 'dashboard' do
    resources :cards
    resources :packs do
      member do
        put 'set_as_current'
        put 'reset_as_current'
      end
    end
  end

  scope module: 'home' do
    resources :users
    resources :user_sessions, only: [:new, :create, :destroy]
  end
end

