# frozen_string_literal: true

module V1
  class JwtDenylist < ApplicationRecord
    include Devise::JWT::RevocationStrategies::Denylist

    self.table_name = 'jwt_denylist'
  end
end