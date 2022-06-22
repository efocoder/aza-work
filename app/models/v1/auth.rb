# frozen_string_literal: true

module V1
  class Auth < ApplicationRecord
    self.table_name = :auths

    devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :validatable,
           :jwt_authenticatable, jwt_revocation_strategy: V1::JwtDenylist

  end

end
