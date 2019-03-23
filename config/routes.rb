Rails.application.routes.draw do
  resources :rooms, only: [:index, :create, :show]
  resources :messages, only: [:create]
  resources :users, only: [:index, :create]

  post '/login', to: 'auth#create'
  get '/messages', to: 'users#messages'

  mount ActionCable.server => '/cable'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
