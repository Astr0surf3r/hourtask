Rails.application.routes.draw do
   
  resources :discounts
  resources :payments
  resources :payment_items

  resources :companies
  resources :projects do
    resources :tasks
  end	
  
  get 'all-tasks', to: "tasks#all_tasks"
  
  get 'get/pdf', to: "projects#get_pdf", as: :get_pdf
  get 'get/xls', to: "projects#get_xls", as: :get_xls
  
  get 'get/tasks_pdf', to: "tasks#get_pdf", as: :get_tasks_pdf
  get 'get/tasks_xls', to: "tasks#get_xls", as: :get_tasks_xls

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "projects#welcome"

end
