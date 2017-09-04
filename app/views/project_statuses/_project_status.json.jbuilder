json.extract! project_status, :id, :name, :position, :project_type_id, :created_at, :updated_at
json.url project_status_url(project_status, format: :json)
