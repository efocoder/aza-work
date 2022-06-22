module ApiHelpers
  def json_body(response)
    JSON.parse(response.body)
  end

  def auth_header(auth)
    Devise::JWT::TestHelpers.auth_headers(valid_headers, auth)
  end
end

RSpec.configure do |config|
  config.include ApiHelpers, type: :request
end
