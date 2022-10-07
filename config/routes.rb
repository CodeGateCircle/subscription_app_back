Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "homes#index"

  post '/subscriptions', to: 'subscriptions#create'
  get '/subscriptions/:user_id', to: 'subscriptions#show'

  post '/account', to: 'users#create'
  get '/account/:id', to: 'users#show'
  put '/account' , to: 'users#update'

end
