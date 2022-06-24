class ApplicationController < ActionController::API
  include Pagy::Backend
  include Shared
  # include ActionController::MimeResponds
  before_action :authenticate_auth!
  after_action { pagy_headers_merge(@pagy) if @pagy }

  respond_to :json
  wrap_parameters format: [:json]

  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  rescue_from ActionController::ParameterMissing, with: :bad_request
  rescue_from ActionController::RoutingError, with: :no_route_found


  def no_route_found
    render json: create_response(404, 'Invalid path', nil), status: :not_found
  end

  private

  def not_found
    render json: create_response(404, 'Record not found', nil), status: :not_found
  end

  def bad_request
    render json: create_response(400, 'Bad Request. POST requests need body', nil), status: :bad_request
  end


end
