Rails.application.routes.draw do


  resources :kotobas
  get 'progresses/new'
  get 'progresses/edit'
  devise_for :users
  root 'landing_pages#home'

  get '/home', to: 'landing_pages#home'
  get '/help', to: 'landing_pages#help'
  get '/about', to: 'landing_pages#about'
  get '/contact', to: 'landing_pages#contact'
  get '/uploadimage', to: 'landing_pages#uploadimage'

  get '/map', to: 'main_map#map'
  get '/report', to: 'main_map#report'

  get '/api_key', to: 'api_key#index'
  get '/api_key_new', to: 'api_key#new'
  get '/api_key_onoff', to: 'api_key#onoffinactivate'

  resources :vessels
  resources :reports, only: [:create, :destroy, :index]
  resources :progresses, only: [:index, :new, :edit]

  get 'report_delete', to:'reports#hapus'

  get '/add_operation', to: 'operations#add'
  post '/operations', to: 'operations#create'
  get '/edit_operation', to: 'operations#edit'
  delete '/delete_operation', to: 'operations#delete'
  get '/iot_image', to: 'operations#get_image'

  mount ActionCable.server, at: '/cable'
  #get '/users/sign_out', to: 'landing_pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
