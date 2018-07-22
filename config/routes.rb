Rails.application.routes.draw do
  root 'application#home'
  
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  resources :projects do 
    get 'collaborators' => 'users#index'
  end
  
  resources :users do
    resources :projects, only: [:new]
  end
end