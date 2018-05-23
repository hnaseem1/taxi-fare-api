Rails.application.routes.draw do
  
  get 'users/new'
  get 'users/create'
  get 'users/show'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  #routes from before 
  get 'price/show'
  get '/price/:id', to: 'price#show'
  get '/google', to: 'google#index'
  get '/map', to: 'google#map'
  root 'google#index'
  get '/position', to: 'google#position'
  root 'google#map'
  ###

  resource :user, :except => [:destroy] do
  	resources :rides
  end

  resource :sessions, only: [:new, :create, :destroy]
end
