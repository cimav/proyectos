json.extract! project, :id, :name, :number, :internal_name, :goal, :manager_id, :agent_id, :department_id, :business_unit_id, :project_type_id, :status, :created_at, :updated_at
json.url project_url(project, format: :json)
