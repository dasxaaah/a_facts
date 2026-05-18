json.extract! post, :id, :body, :created_at, :updated_at
json.title "Пост ##{post.id}"
json.url post_url(post, format: :json)
