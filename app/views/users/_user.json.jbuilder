json.extract! user, :id, :email, :username, :photo, :cover, :created_at, :updated_at
json.url user_url(user, format: :json)
