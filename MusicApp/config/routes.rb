Rails.application.routes.draw do

  resources :users, except: [:destroy, :edit, :update, :index]
  resource :session, except: [:show, :edit, :update]

  resources :bands do
    resources :albums, only: [:new]
  end

  resources :albums, only: [:create, :destroy, :edit, :show, :update] do
    resources :tracks, only: [:new]
  end

  resources :tracks, only: [:create, :destroy, :edit, :show, :update]

end
