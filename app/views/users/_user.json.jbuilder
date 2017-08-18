json.extract! user, :id, :name, :email, :department_id, :status, :supervisor_id, :created_at, :updated_at
json.url user_url(user, format: :json)
