Rails.application.routes.draw do


  # get 'reset/show'
  #get 'reset/new'
  # get 'reset/create'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  ##password reset route
  get   '/reset', to: 'reset#create'
  get   '/reset/confirm', to: 'reset#show', as: 'pass_reset'

  post '/reset/confirm/success', to: 'reset#reset_pass', as: 'pass_reset_success'

  root 'google#index'

  #routes from before
  get '/google', to: 'google#index'

  resource :user, :except => [:destroy] do
  	resources :rides
  end

  resource :sessions, only: [:new, :create, :destroy]
  resource :resets, only: [:new, :show, :create], controller: "reset"

  get '/price/show', to: 'price#show'
end
