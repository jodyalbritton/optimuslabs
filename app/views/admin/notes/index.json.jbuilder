json.array!(@notes) do |note|
  json.extract! note, :id, :subject, :body, :created_by_id, :notable
  json.url note_url(note, format: :json)
end
