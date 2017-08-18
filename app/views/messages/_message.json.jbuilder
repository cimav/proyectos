json.extract! message, :id, :title, :content, :project_id, :user_id, :created_at, :updated_at
json.url message_url(message, format: :json)
