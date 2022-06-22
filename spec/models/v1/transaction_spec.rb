require 'rails_helper'

RSpec.describe V1::Transaction, type: :model do
  before { FactoryBot.build(:transaction) }

  context 'Validations' do
    it { should validate_presence_of(:customer_id).with_message('customer id required') }
    context 'validate currencies' do
      it { should validate_presence_of(:input_currency).with_message('input currency required') }
      it { should validate_length_of(:input_currency).is_at_least(3).is_at_most(3) }
      it { should validate_presence_of(:output_currency).with_message('output currency required') }
      it { should validate_length_of(:output_currency).is_at_least(3).is_at_most(3) }
    end

    context 'validate amount' do
      it { should validate_presence_of(:input_amount).with_message('input amount required') }
      it { should validate_presence_of(:output_amount).with_message('output amount required') }
      it { should validate_numericality_of(:input_amount).is_greater_than_or_equal_to(1) }
      it { should validate_numericality_of(:output_amount).is_greater_than_or_equal_to(1) }
    end

    context 'text transaction id generated' do
      it 'validates return data' do
        trans = V1::Transaction.new
        resp = trans.send(:generate_transaction_id)
        expect(resp.class).to be String
        expect(resp.size).to be 14
      end
    end

  end
end
