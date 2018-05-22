Rails.application.routes.draw do
  resources :aircraft_models, param: :icao_code do
    resources :aircrafts, shallow: true
  end
  resources :airports
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
