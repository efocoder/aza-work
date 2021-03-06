module V1
  class TransactionsController < ApplicationController
    before_action :set_v1_transaction, only: %i[show update]

    # GET /v1/transactions
    def index
      @pagy, @v1_transactions = pagy V1::Transaction.load_transactions
      # logger.info pagy_headers_merge(@pagy).inspect #["Link"]
      # logger.info @pagy.inspect
      # logger.info request.inspect
      render json: create_response(200, 'Request successful',
                                   serialize_data(V1::TransactionSerializer, @v1_transactions)), status: :ok
    end

    # GET /v1/transactions/1
    def show
      render json: create_response(200, 'Request successful',
                                   serialize_data(V1::TransactionSerializer, @v1_transaction)), status: :ok
    end

    # POST /v1/transactions
    def create
      @v1_transaction = V1::Transaction.new(v1_transaction_params)
      @v1_transaction.transaction do
        if @v1_transaction.save
          render json: create_response(201, 'Transaction created successfully',
                                       serialize_data(V1::TransactionSerializer, @v1_transaction)), status: :created
        else
          render json: @v1_transaction.errors, status: :unprocessable_entity
        end
      end
    end

    def update
      @v1_transaction.transaction do
        if @v1_transaction.update(v1_transaction_params)
          render json: create_response(200, 'Transaction updated successfully',
                                       serialize_data(V1::TransactionSerializer, @v1_transaction)), status: :ok
        else
          render json: @v1_transaction.errors, status: :unprocessable_entity
        end
      end
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_v1_transaction
      @v1_transaction ||= V1::Transaction.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def v1_transaction_params
      params.require(:transaction).permit(:transaction_id, :customer_id, :input_currency, :input_amount,
                                          :output_currency, :output_amount, :status)
    end
  end
end
