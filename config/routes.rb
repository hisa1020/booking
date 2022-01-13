Rails.application.routes.draw do
  root to: 'top#index'
  
  devise_for :users, skip: [:passwords], controllers:{
    registrations: 'users/registrations',
    sessions: 'users/sessions',
  }
  get 'users/account', to: 'users#show'
  get 'users/profile', to: 'users#profile', as:'users_profile'
  resources :users, only: [:show, :update]
  
  resources :rooms do
    collection do
      get 'posts'
      get 'search'
    end
  end

  
  
  
  resources :reservations, only: [:index, :new, :create, :show, :destroy] 
  get 'reservations/index'

end
