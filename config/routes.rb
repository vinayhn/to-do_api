Rails.application.routes.draw do
  resources :tasks
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #get '/login', to: 'users#login'
  post '/create_user', to: 'users#create_user'
  post '/login', to: 'users#login'
  post '/logout', to: 'users#logout'
  post'/send_new_password_email', to: 'users#send_new_password_email'
  get '/index' , to: 'users#index'
  get '/task_index', to: 'tasks#index'
  post '/create_task', to: 'tasks#create'
  post '/edit_task', to: 'tasks#edit_task'
  post '/delete_task', to: 'tasks#delete_task'

  get '/view_tasks', to: 'tasks#view_tasks'

end
