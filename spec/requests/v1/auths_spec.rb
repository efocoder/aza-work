require 'rails_helper'

RSpec.describe '/auth/sign_in', type: :request do
  let(:user) { FactoryBot.create(:auth) }
  let(:invalid_credentials) { { email: user.email, password: 'mypass12345' } }
  let(:valid_credentials) { { email: user.email, password: user.password } }

  describe 'POST /auth/sign_in' do
    context 'Login' do
      it 'does not login user' do
        post auth_session_url, params: { auth: invalid_credentials }, as: :json
        expect(response).to have_http_status(:unauthorized)
      end

      it 'does  login user' do
        post auth_session_url, params: { auth: valid_credentials }, as: :json
        expect(response).to have_http_status(:ok)
      end
    end
  end
end
