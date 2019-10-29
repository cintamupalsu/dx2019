Rails.application.routes.draw do
  get 'main_map/map'
  devise_for :users
  root 'landing_pages#home'
  get '/home', to: 'landing_pages#home'
  get '/help', to: 'landing_pages#help'
  get '/about', to: 'landing_pages#about'
  get '/contact', to: 'landing_pages#contact'


  get '/map', to: 'main_map#map'

  #get '/users/sign_out', to: 'landing_pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
