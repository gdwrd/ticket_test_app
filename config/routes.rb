Rails.application.routes.draw do
  devise_for :users
  resources :tickets, except: [ :edit ]
  post "/tickets/:id/comments", to: "comments#create", as: "new_comments"

  root "pages#home"
  get "about", to: "pages#about"
end
