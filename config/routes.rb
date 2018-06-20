Rails.application.routes.draw do
  root to: 'home#index'

  resources :aircraft_models, param: :icao_code do
    resources :aircrafts, shallow: true do
      post 'import', on: :collection
    end
  end
  resources :airports
end
