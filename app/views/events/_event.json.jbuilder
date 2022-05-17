json.extract! event, :id, :slug, :title, :description, :start_time, :end_time, :location, :event_link, :source, :created_at, :updated_at
json.url event_url(event, format: :json)
