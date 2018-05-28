Rails.application.routes.draw do


  get 'documentations/index'
  # get 'reset/show'
  #get 'reset/new'
  # get 'reset/create'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  ##password reset route
  get   '/resets/new', to: 'resets#new', as: 'new_resets'
  post '/resets', to: 'resets#create', as: 'resets'
  get   '/resets/confirm', to: 'resets#show', as: 'pass_reset'
  post '/resets/confirm/success', to: 'resets#reset_pass', as: 'pass_reset_success'
  ##
  root 'google#index'

  #routes from before
  get '/google', to: 'google#index'

  resource :user, :except => [:destroy] do
  	resources :rides
  end

  resource :sessions, only: [:new, :create, :destroy]


  get '/price/show', to: 'price#show'

end
