Rails.application.routes.draw do

  namespace :api, defaults: { format: :json } do
    resources :user, only: [:create]
    resources :benches, only: [:index, :create]
    resource :session, only: [:create, :destroy]
  end

  root to: 'static_pages#root'

end
