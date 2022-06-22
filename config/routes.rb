# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :v1 do
    resources :transactions, only: %i[index create show]
  end
  devise_for :auths, class_name: 'V1::Auth',
                     controllers: {
                       sessions: 'v1/auth/sessions',
                       registrations: 'v1/auth/registrations'
                     }

  match '*unmatched', to: 'application#no_route_found', via: :all
end
