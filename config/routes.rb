Rails.application.routes.draw do

  post '/rate' => 'rater#create', :as => 'rate'
  root 'static_pages#index'
  get  '/contact',     to: 'contacts#new'
  get  'about',        to: 'static_pages#about'
  get  'restaurants',  to: 'static_pages#restaurants'
  get  'beauty_spas',  to: 'static_pages#beauty_spas'
  get  'discover',     to: 'static_pages#discover'
  get  'gadgets',      to: 'static_pages#gadgets'
  get  'wishlist',     to: 'static_pages#wishlist'
  get  'coupon',       to:'static_pages#coupon'
  resources 'contacts', only: [:new, :create, :show]
  resources :articles
  resources :newsletters , only:[:new,:create]
  resources :categories
  resources :deals do
    resources :reviews
    resources :coupons, only: [:new, :create]
    match 'vote', action: :vote, via: [:put,:delete], on: :member
    get 'search/*query', to: 'deals#index', as: :search, on: :collection
  end

  devise_for :users, :controllers => { :omniauth_callbacks => 'callbacks' , registrations: 'registrations'}
  devise_scope :user do
    get    'login',      to: 'devise/sessions#new'
    post   'login',      to: 'devise/sessions#new'
    get    'register',   to: 'devise/registrations#new'
    post   'register',   to: 'devise/registrations#new'
    get 'logout',     to: 'devise/sessions#destroy'
    delete 'logout',     to: 'devise/sessions#destroy'
    get    'password',   to: 'devise/passwords#new'
    get    'account',    to: 'registrations#edit'
    get    'u/:id' ,     to: 'users#show', :as => 'profile'
  end

end
