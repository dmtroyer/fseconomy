Rails.application.routes.draw do
  root to: 'home#index'

  resources :aircraft_models, param: :icao_code do
    resources :aircrafts, shallow: true
  end
  resources :airports
end
