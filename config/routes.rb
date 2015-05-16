Rails.application.routes.draw do
  devise_for :users, only: []

  namespace :v1, defaults: {format: :json} do
    resource :login, only: [:create], controller: :sessions
    resources :users, only: [:create]
  end
end
