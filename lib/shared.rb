module Shared
  TRANS_STATUS = { pending: 'PENDING', failed: 'FAILED', completed: 'COMPLETED', deleted: 'DELETED' }.freeze

  # app wide response format
  def create_response(status_code, message, data = [], src = nil)
    resp = {}
    resp['status_code'] = status_code
    resp['message'] = message
    resp['data'] = data unless data.nil?

    resp.to_json
  end

  # serializer data with json api serializer
  def serialize_data(serializer, data)
    resp = []
    if data.is_a?(ActiveRecord::Relation)
      serializer.new(data).serializable_hash[:data].each { |d| resp << d[:attributes] }
    else
      resp << serializer.new(data).serializable_hash[:data][:attributes]
    end
    resp
  end

end
