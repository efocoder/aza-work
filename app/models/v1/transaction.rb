# frozen_string_literal: true

module V1
  class Transaction < ApplicationRecord
    self.table_name = :transactions # the scaffold expects v2_transactions, but wanted to keep it as transaction
    self.primary_key = :transaction_id

    before_create :generate_transaction_id

    validates :customer_id, presence: { message: 'customer id required' }
    validates :input_currency, presence: { message: 'input currency required' }, length: { minimum: 3, maximum: 3 }
    validates :output_currency, presence: { message: 'output currency required' }, length: { minimum: 3, maximum: 3 }
    validates :input_amount, presence: { message: 'input amount required' }, numericality: { greater_than_or_equal_to: 1 },
                             format: { with: /\A\d{1,10}(\.\d{1,2})?\z/ }
    validates :output_amount, presence: { message: 'output amount required' }, numericality: { greater_than_or_equal_to: 1 },
                              format: { with: /\A\d{1,10}(\.\d{1,2})?\z/ }

    validates_uniqueness_of :transaction_id


    scope :load_transactions, -> { order(created_at: :desc) }

    private

    # generate unique id for transaction
    def generate_transaction_id
      # AZAFXT22060001
      current = V1::Transaction.last
      self.transaction_id = if current.present? && current.transaction_id[6, 4] == Time.now.strftime('%y%m')
                              "AZAFXT#{current.transaction_id[6, 4]}#{('%04d' % current.transaction_id[10,4].to_i).next}"
                              # select from index 10, since transaction id has a fixed length of 14
                            else
                              "AZAFXT#{Time.now.strftime('%y%m')}0001"
                            end
    end
  end

end
