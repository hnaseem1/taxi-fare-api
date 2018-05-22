Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'price/show'
  get '/price/:id', to: 'price#show'
  get '/google', to: 'google#index'
  get '/map', to: 'google#map'
  root 'google#index'
  get '/position', to: 'google#position'
  root 'google#map'
end
