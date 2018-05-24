Rails.application.routes.draw do


  get 'reset/show'
  get 'reset/new'
  get 'reset/create'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'google#index'

  #routes from before
  get '/google', to: 'google#index'

  resource :user, :except => [:destroy] do
  	resources :rides
  end

  resource :sessions, only: [:new, :create, :destroy]

  get '/price/show', to: 'price#show'
end
