json.extract! comentario, :id, :content, :user_id, :publicacion_id, :created_at, :updated_at
json.url comentario_url(comentario, format: :json)
