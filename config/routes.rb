Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'pages#index'

  get '/login', to: 'user_sessions#new'
  post '/sessions', to: 'user_sessions#create'
  delete '/sessions', to: 'user_sessions#destroy'


  get '/edit_password', to: 'users#edit_password'
  patch '/edit_password', to: 'users#update_password'

  get '/edit_profile', to: 'users#edit_profile'
  patch '/edit_profile', to: 'users#update_profile'

  resources :users, only: [:index, :new, :create]
end
