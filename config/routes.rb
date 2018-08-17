Rails.application.routes.draw do
  resources :tables, only: [:index, :new, :create, :destroy] do
    get 'map'
  end

  resources :guests, only: [:new, :create, :destroy] do
    collection do
      get 'search'
    end
  end

  get 'welcome', to: 'guests#welcome', as: 'welcome'

  root 'guests#welcome'
end
