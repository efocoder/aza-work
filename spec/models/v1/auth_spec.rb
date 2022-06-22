require 'rails_helper'

RSpec.describe V1::Auth, type: :model do
  before { FactoryBot.build(:auth) }

  context 'validation' do
    it { should validate_presence_of(:email).with_message("can't be blank") }
    it { should validate_uniqueness_of(:email).with_message('has already been taken').case_insensitive }
    it { should validate_presence_of(:password).with_message("can't be blank") }
    it { should validate_length_of(:password).is_at_least(6).with_message('is too short (minimum is 6 characters)') }
  end
end
