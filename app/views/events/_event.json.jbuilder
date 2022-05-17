json.extract! event, :id, :slug, :title, :description, :start_date, :end_date, :location, :event_link, :source, :created_at, :updated_at
json.url event_url(event, format: :json)
