json.extract! schedule, :id, :title, :content, :project_id, :start_date, :end_date, :schedule_type, :user_id, :created_at, :updated_at
json.url schedule_url(schedule, format: :json)
