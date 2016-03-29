Rails.application.routes.draw do
  root 'home#index'

  devise_for :users, :controllers => { :omniauth_callbacks => 'callbacks' , registrations: 'registrations'}
  devise_scope :user do
    get    'login',      to: 'devise/sessions#new'
    post   'login',      to: 'devise/sessions#new'
    get    'register',   to: 'devise/registrations#new'
    post   'register',   to: 'devise/registrations#new'
    delete 'logout',     to: 'devise/sessions#destroy'
    get    'password',   to: 'devise/passwords#new'
    get    'account',    to: 'registrations#edit'
    get    'u/:id' ,     to: 'users#show', :as => 'profile'
  end

end
