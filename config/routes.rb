Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "homes#index"

  post '/subscriptions', to: 'subscriptions#create'
  get '/subscriptions', to: 'subscriptions#show'
  delete '/subscriptions/:id', to: 'subscriptions#delete'
  post '/subscriptions/:id', to: 'subscriptions#update'

  post '/account', to: 'users#create'
  get '/account/:id', to: 'users#show'
  put '/account' , to: 'users#update'

  get '/search', to: 'subscriptions#search'

  post '/test', to: 'test#create'

end
