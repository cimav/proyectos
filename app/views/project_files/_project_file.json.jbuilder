json.extract! project_file, :id, :name, :project_folder_id, :description, :user_id, :created_at, :updated_at
json.url project_file_url(project_file, format: :json)
