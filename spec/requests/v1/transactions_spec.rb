require 'rails_helper'

RSpec.describe '/v1/transactions', type: :request do
  let(:valid_attributes) { attributes_for(:transaction) }
  let(:invalid_attributes) { attributes_for(:transaction, customer_id: nil) }
  let(:empty_body) {}
  let(:user) { auth_header(FactoryBot.create(:auth)) }
  let(:valid_headers) do
    {}
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      V1::Transaction.create! valid_attributes
      get v1_transactions_url, headers: user, as: :json

      expect(response).to be_ok
      expect(response.content_type).to match 'application/json'
      expect(json_body(response).class).to be Hash
      expect(json_body(response)['status_code']).to be 200
      expect(json_body(response)['data'].class).to be Array
      expect(json_body(response)['data'].length).to be 1
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      transaction = V1::Transaction.create! valid_attributes
      get v1_transaction_url(transaction), headers: user, as: :json

      expect(response).to be_ok
      expect(response.content_type).to match 'application/json'
      expect(json_body(response).class).to be Hash
      expect(json_body(response)['status_code']).to be 200
      expect(json_body(response)['data'].class).to be Array
      expect(json_body(response)['data'].length).to be 1
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new V1::Transaction' do
        post v1_transactions_url, params: { transaction: valid_attributes }, headers: user, as: :json

        expect(response).to have_http_status(:created)
        expect { response }.to change(V1::Transaction, :count).by_at_most(1)
        expect(response.content_type).to match 'application/json'
        expect(json_body(response).class).to be Hash
        expect(json_body(response)['status_code']).to be 201
        expect(json_body(response)['data'].class).to be Array
        expect(json_body(response)['data'].length).to be 1
      end

      context 'with invalid parameters' do
        it 'does not create a new V1::Transaction' do
          post v1_transactions_url, params: { transaction: invalid_attributes }, headers: user, as: :json

          expect(response).to have_http_status(:unprocessable_entity)
          expect(response.content_type).to match 'application/json'
          expect(json_body(response).class).to be Hash
          expect { response }.to change(V1::Transaction, :count).by(0)
        end
      end
    end
  end
end
