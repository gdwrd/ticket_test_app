Rails.application.routes.draw do
  devise_for :users
  resources :tickets, except: [ :edit ]
  
  root "pages#home"
  get "about", to: "pages#about"
end
