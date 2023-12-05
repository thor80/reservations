Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'pages#index'
  get 'pages/secret'

  get '/login', to: 'user_sessions#new'
  post '/sessions', to: 'user_sessions#create'
  delete '/sessions', to: 'user_sessions#destroy'

  resources :users, only: [:index, :new, :create]
end
