json.extract! person, :id, :type, :name, :email, :phone, :notes, :attachable_id, :attachable_type, :created_at, :updated_at
json.url person_url(person, format: :json)
