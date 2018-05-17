Rails.application.routes.draw do
  resources :aircrafts
  resources :aircraft_models
  resources :airports
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
