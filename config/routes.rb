Rails.application.routes.draw do
  devise_for :users
  resources :tickets
  
  root "pages#home"
end
