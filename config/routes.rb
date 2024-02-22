Rails.application.routes.draw do
  devise_for :users
  root to: "rooms#index"
  resources :users, only: [:show, :edit, :update]
  resources :rooms do
    resources :posts #do
      ##resources## :comments, only: [:index, :create]
    #end
  end
end