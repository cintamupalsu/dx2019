Rails.application.routes.draw do
  root 'landing_pages#home'
  get 'landing_pages/home'
  get 'landing_pages/help'
  get 'landing_pages/about'
  get 'landing_pages/contact'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
