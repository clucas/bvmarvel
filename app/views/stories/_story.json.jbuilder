json.extract! story, :id, :title, :marvel_uuid, :description, :created_at, :updated_at
json.url story_url(story, format: :json)
