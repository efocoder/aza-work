module V1
  class TransactionSerializer
    include JSONAPI::Serializer
    attributes :transaction_id, :customer_id, :input_currency, :output_currency, :input_amount, :output_amount

    attribute :transaction_date do |object|
      object.created_at.strftime('%Y-%m-%d at %I:%M%p')
    end
  end
end
