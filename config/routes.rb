Rails.application.routes.draw do
   
  resources :payments
  resources :companies
  resources :projects do
    resources :tasks
  end	
  
  get 'all-tasks', to: "tasks#all_tasks"

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  root "projects#index"

end
