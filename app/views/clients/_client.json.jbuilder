json.extract! client, :id, :short_name, :real_name, :address, :company_size, :industry_id, :created_at, :updated_at
json.url client_url(client, format: :json)
