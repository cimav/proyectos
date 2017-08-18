Rails.application.routes.draw do
  root to: 'projects#index'
  resources :business_units
  resources :schedules
  resources :messages
  resources :departments
  resources :users
  resources :project_folders
  resources :project_files
  resources :industries
  resources :people
  resources :institutions
  resources :company_sizes
  resources :clients
  resources :project_types
  resources :themes
  resources :projects
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
