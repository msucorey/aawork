TodoApp::Application.routes.draw do

  resources :users, :todo_lists, :todo_items
  resource :session
end
