Rails.application.routes.draw do

  root 'pages#home'
  
  resources :users
  
  resources :users do
    resources :transactions
  end
  resources :transactions
end
