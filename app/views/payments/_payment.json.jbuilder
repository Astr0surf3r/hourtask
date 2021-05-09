json.extract! payment, :id, :amount, :currency, :payment_method, :project_id, :created_at, :updated_at
json.url payment_url(payment, format: :json)
