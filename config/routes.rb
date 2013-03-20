Sw4tch::Application.routes.draw do

  get '/swatches/:id/gist/:syntax/:is_public', to: 'swatches#gist', as: 'gist'
  get '/swatches/:id/swatchbook/:swatchbook_id/add', to: 'swatches#add_to_swatchbook', as: 'add_to_swatchbook'
  get '/swatches/:id/swatchbook/:swatchbook_id/remove', to: 'swatches#remove_from_swatchbook', as: 'remove_from_swatchbook'

  resources :swatches do

    member do
      get :fork
    end

    collection do
      get :search
    end
  end

  post '/markup/compile/:from/:to', to: 'markup#compile', as: 'markup_compile'

  match '/dashboard', to: 'users#show', as: 'dashboard'

  resources :users do
    resources :swatchbooks
  end

  resources :swatchbooks

  match '/auth/:provider/(:callback)', to: 'sessions#create', as: 'sign_in'
  match '/logout', to: 'sessions#destroy', as: 'logout'

  root to: 'home#index'
end
