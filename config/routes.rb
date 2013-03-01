Sw4tch::Application.routes.draw do

  match '/swatches/:id/gist/:syntax/:is_public', to: 'swatches#gist', as: 'gist'

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

  match '/auth/:provider/(:callback)', to: 'sessions#create', as: 'sign_in'
  match '/logout', to: 'sessions#destroy', as: 'logout'

  root to: 'home#index'
end
