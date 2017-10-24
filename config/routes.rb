Rails.application.routes.draw do
  resources :project_statuses
  root to: 'projects#index'

  get '/auth/:provider/callback' => 'sessions#create'
  get '/auth/failure' => 'sessions#failure'
  get "/logout" => 'sessions#destroy'
  get '/login' => 'login#index'
  post '/crear-carpeta' => 'project_folders#add_folder'

  scope(:path_names => { :new => "nuevo", :edit => "editar", :create => "crear", :delete => "eliminar" }) do
    resources :project_files, :path=>'archivos'
    resources :projects, :path => "proyectos"  do
      member do
        get :messages, :path => "mensajes"
        get :new_message, :path => "mensajes/nuevo"
        get :show_message, :path => "mensajes/:message_id"
        get :edit_message, :path => "mensajes/:message_id/editar"

        get :schedules, :path => "calendario"
        get :new_schedule, :path => "calendario/nuevo"
        get :show_schedule, :path => "calendario/:schedule_id"
        get :edit_schedule, :path => "calendario/:schedule_id/editar"

        get :files, :path => "documentos"
        get :folders, :path => "documentos/carpetas"
        get :folder_files, :path => "documentos/:project_folder_id"
        get :folder_files_list, :path => "documentos/:project_folder_id/listado"


        get :budget, :path => "presupuesto"

        get :people, :path => "personas"

        get :services, :path => "servicios"
      end
    end   
  end

  get '/configuracion' => 'admin#index'

  scope '/configuracion' do
    scope(:path_names => { :new => "nuevo", :edit => "editar" }) do
      resources :users, :path => "usuarios"   
      resources :project_types, :path => "tipos-de-proyectos"  do
        member do
          post "reorder-status"
          post "add-status"
          post "add-folder"
          post "update-status"
          get  "statuses"
        end
      end
      resources :industries, :path => "industrias"   
      resources :company_sizes, :path => "company_sizes"   
      resources :departments, :path => "departamentos"   
      resources :clients, :path => "clientes"   
    end 
  end



  resources :business_units
  resources :schedules
  resources :messages
  resources :departments
  resources :project_folders
  
  resources :industries
  resources :people
  resources :institutions
  resources :company_sizes
  resources :clients
  resources :themes
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
