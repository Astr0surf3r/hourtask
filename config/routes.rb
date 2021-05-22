Rails.application.routes.draw do
   
  resources :payments
  resources :payment_items

  resources :companies
  resources :projects do
    resources :tasks
  end	
  
  get 'all-tasks', to: "tasks#all_tasks"
  
  get 'get/pdf', to: "projects#get_pdf", as: :get_pdf

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "projects#index"

end
