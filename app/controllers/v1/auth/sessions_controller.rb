# frozen_string_literal: true

class V1::Auth::SessionsController < Devise::SessionsController
  wrap_parameters :auth, format: [:json]
  respond_to :json
  include Shared
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  protected

  def respond_with(resource, _opts = {})
    return unless auth_signed_in?

    resp = create_response(200, 'Signed in successfully', nil)
    resp = JSON.parse(resp)
    resp['token'] = request.env['warden-jwt_auth.token']
    render json: resp, status: :ok
  end

  def respond_to_on_destroy
    current_auth ? log_out_success : log_out_failure
  end

  def log_out_success
    render json: { message: 'You are Logged out.' }, status: :ok
  end

  def log_out_failure
    render json: { message: 'Logged out failure.' }, status: :unauthorized
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
