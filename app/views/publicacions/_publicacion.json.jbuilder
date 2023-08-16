json.extract! publicacion, :id, :title, :content, :user_id, :created_at, :updated_at
json.url publicacion_url(publicacion, format: :json)
