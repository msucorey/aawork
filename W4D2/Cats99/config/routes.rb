Rails.application.routes.draw do

  resources :cats, only: [:index, :show, :new, :create, :edit, :update]

  resources :cat_rental_requests, only: [:new, :create, :index, :show]

  post 'cat_rental_requests/approve/:id', :to => 'cat_rental_requests#approve', as: :approve
  post 'cat_rental_requests/deny/:id', :to => 'cat_rental_requests#deny', as: :deny
end
