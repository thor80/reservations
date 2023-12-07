Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # this is the default content that is shown when you access to http://localhost:3000
  root 'pages#index'

  # Here are the roots to access login page.
  get '/login', to: 'user_sessions#new'
  # Here is the root when you login, and create session for user
  post '/sessions', to: 'user_sessions#create'
  # This is to remove session for user and log him out
  delete '/sessions', to: 'user_sessions#destroy'

  # Here is the link to the page where the user edit his password
  get '/edit_password', to: 'users#edit_password'
  # Here is the link to save the new password and go back to root the index page.
  patch '/edit_password', to: 'users#update_password'

  # Here is the link to send the user to the profile edition page
  get '/profile/:id', to: 'users#edit_profile', as: 'profile'
  # Here is the link to update the user profile and send him to index page.
  patch '/profile/:id', to: 'users#update_profile', as: 'edit_profile'

  # Here are the links to go to new user form, and to create user.
  get '/users/new', to: 'users#new'
  post '/users/new', to: 'users#create'

end
