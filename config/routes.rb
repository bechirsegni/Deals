Rails.application.routes.draw do

  root 'static_pages#index'
  get  '/contact',     to: 'contacts#new'
  get  'about',        to: 'static_pages#about'

  resources 'contacts', only: [:new, :create]
  resources :articles

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
