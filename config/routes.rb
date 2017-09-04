Rails.application.routes.draw do
  root to: 'projects#index'

  get '/auth/:provider/callback' => 'sessions#create'
  get '/auth/failure' => 'sessions#failure'
  get "/logout" => 'sessions#destroy'
  get '/login' => 'login#index'


  scope(:path_names => { :new => "nuevo", :edit => "editar" }) do
    resources :projects, :path => "proyectos"    
  end

  get '/configuracion' => 'admin#index'

  scope '/configuracion' do
    scope(:path_names => { :new => "nuevo", :edit => "editar" }) do
      resources :users, :path => "usuarios"   
      resources :industries, :path => "industrias"   
      resources :company_sizes, :path => "company_sizes"   
      resources :departments, :path => "departamentos"   
      resources :clients, :path => "clientes"   
      resources :project_types, :path=>"proyectos"
    end 
  end

  resources :business_units
  resources :schedules
  resources :messages
  resources :departments
  resources :project_folders
  resources :project_files
  resources :industries
  resources :people
  resources :institutions
  resources :company_sizes
  resources :clients
  resources :project_types
  resources :themes
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
