json.extract! taskdet, :id, :content, :status, :user_id, :report_id, :created_at, :updated_at
json.url taskdet_url(taskdet, format: :json)
