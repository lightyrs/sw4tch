Sw4tch::Application.routes.draw do

  resources :swatches

  post '/markup/compile/:from/:to', to: 'markup#compile', as: 'markup_compile'

  match '/dashboard', to: 'users#show', as: 'dashboard'
  resources :users

  match '/auth/:provider/(:callback)', to: 'sessions#create', as: 'sign_in'
  match '/logout', to: 'sessions#destroy', as: 'logout'

  root to: 'home#index'
end
