Rails.application.routes.draw do
  root 'application#home'
  
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  resources :projects do 
    # resources :users, only: [:index]
    get 'collaborators' => 'users#index'
  end
end