Rails.application.routes.draw do

  post '/rate' => 'rater#create', :as => 'rate'
  root 'static_pages#index'
  get  '/contact',     to: 'contacts#new'
  get  'about',        to: 'static_pages#about'
  get  'restaurants',        to: 'static_pages#restaurants'


  resources 'contacts', only: [:new, :create]
  resources :articles
  resources :categories
  resources :deals do
    resources :reviews
    match 'vote', action: :vote, via: [:put,:delete], on: :member
  end

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
